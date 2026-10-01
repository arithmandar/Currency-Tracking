#!/usr/bin/env python3
"""
Generate Lua item tables from Wowhead item-list (filter) pages.

Usage:
    python wowhead_to_item_tables.py                 # uses wowhead_input.txt
    python wowhead_to_item_tables.py my_input.txt    # custom input file
    python wowhead_to_item_tables.py my_input.txt out.lua

Input file format (one entry per line, '#' starts a comment):
    TableName | ExpansionNumber | ExpansionName | WowheadURL

Example:
    Alchemy | 10 | Dragonflight | https://www.wowhead.com/items?filter=87:194:166;1:1:10;0:1:0

Entries that share the same TableName are merged into ONE Lua table,
with one [ExpansionNumber] sub-table per entry.

No third-party packages required (standard library only).
"""

from __future__ import annotations

import html
import json
import re
import sys
import time
from collections import OrderedDict
from pathlib import Path
from typing import Any, NamedTuple
from urllib.error import HTTPError, URLError
from urllib.request import Request, urlopen

SCRIPT_DIR = Path(__file__).resolve().parent
DEFAULT_INPUT = SCRIPT_DIR / "wowhead_input.txt"
DEFAULT_OUTPUT = SCRIPT_DIR / "wowhead_items.lua"

# IMPORTANT: Wowhead's CDN (CloudFront) blocks requests that send a full
# Chrome/Firefox User-Agent from a non-browser client (the TLS fingerprint
# does not match the claimed browser). A short generic UA is accepted.
USER_AGENTS = [
    "Mozilla/5.0",
    "Mozilla/5.0 (compatible; WowheadLuaExporter/1.0)",
]

REQUEST_DELAY_SECONDS = 2.0   # polite pause between page downloads
WOWHEAD_LIST_LIMIT = 1000     # Wowhead list views are capped at 1000 rows


class Entry(NamedTuple):
    table_name: str
    expansion_number: int
    expansion_name: str
    url: str
    line_number: int


# --------------------------------------------------------------------------
# Input
# --------------------------------------------------------------------------
def read_input_file(input_file: Path) -> list[Entry]:
    entries: list[Entry] = []
    text = input_file.read_text(encoding="utf-8-sig")  # tolerate BOM

    for line_number, raw_line in enumerate(text.splitlines(), start=1):
        line = raw_line.strip()
        if not line or line.startswith("#"):
            continue

        parts = [p.strip() for p in line.split("|", maxsplit=3)]
        if len(parts) != 4:
            raise ValueError(
                f"Line {line_number}: expected 4 values separated by '|'.\n"
                f"  Received: {raw_line}"
            )

        table_name, expansion_number, expansion_name, url = parts

        if not table_name:
            raise ValueError(f"Line {line_number}: table name is empty.")
        if table_name.startswith("items."):
            table_name = table_name[len("items."):]
        if not expansion_number.isdigit():
            raise ValueError(
                f"Line {line_number}: expansion number must be numeric, "
                f"got {expansion_number!r}."
            )
        if not re.fullmatch(r"https?://(www\.)?wowhead\.com/\S+", url):
            raise ValueError(
                f"Line {line_number}: not a plain Wowhead URL: {url!r}"
            )

        entries.append(
            Entry(table_name, int(expansion_number), expansion_name, url, line_number)
        )

    return entries


# --------------------------------------------------------------------------
# Download
# --------------------------------------------------------------------------
def download_page(url: str) -> str:
    last_error: Exception | None = None

    for user_agent in USER_AGENTS:
        request = Request(
            url,
            headers={
                "User-Agent": user_agent,
                "Accept": "text/html,application/xhtml+xml",
                "Accept-Language": "en-US,en;q=0.9",
            },
        )
        try:
            with urlopen(request, timeout=30) as response:
                charset = response.headers.get_content_charset() or "utf-8"
                return response.read().decode(charset, errors="replace")
        except HTTPError as error:
            last_error = error
            if error.code == 403:
                continue  # try next User-Agent
            raise RuntimeError(
                f"Wowhead returned HTTP {error.code} {error.reason} for {url}"
            ) from error
        except URLError as error:
            raise RuntimeError(
                f"Could not connect to Wowhead ({error.reason}) for {url}"
            ) from error

    raise RuntimeError(
        "Wowhead returned HTTP 403 Forbidden for every User-Agent tried.\n"
        f"  URL: {url}\n"
        "  Your IP may be temporarily rate-limited. Wait a few minutes and retry."
    ) from last_error


# --------------------------------------------------------------------------
# Parsing
# --------------------------------------------------------------------------
def extract_balanced(text: str, start: int, open_ch: str, close_ch: str) -> str | None:
    """Return the balanced {...} or [...] block starting at/after `start`."""
    begin = text.find(open_ch, start)
    if begin == -1:
        return None

    depth = 0
    in_string: str | None = None
    escape = False

    for i in range(begin, len(text)):
        ch = text[i]
        if in_string:
            if escape:
                escape = False
            elif ch == "\\":
                escape = True
            elif ch == in_string:
                in_string = None
            continue
        if ch in ('"', "'"):
            in_string = ch
        elif ch == open_ch:
            depth += 1
        elif ch == close_ch:
            depth -= 1
            if depth == 0:
                return text[begin : i + 1]
    return None


def extract_gatherer_items(page_html: str) -> dict[int, str]:
    """Item ID -> English name from WH.Gatherer.addData(3, 1, {...}) blocks."""
    items: dict[int, str] = {}
    pattern = re.compile(r"WH\.Gatherer\.addData\s*\(\s*3\s*,\s*\d+\s*,")

    for match in pattern.finditer(page_html):
        block = extract_balanced(page_html, match.end(), "{", "}")
        if not block:
            continue
        try:
            data: dict[str, Any] = json.loads(block)
        except json.JSONDecodeError:
            continue
        for key, value in data.items():
            if key.isdigit() and isinstance(value, dict):
                name = value.get("name_enus") or value.get("name") or "Unknown item"
                items.setdefault(int(key), str(name))
    return items


def extract_listview_items(page_html: str) -> dict[int, str]:
    """
    Item ID -> name from `var listviewitems = [...]` (the actual filter result).

    That block is JavaScript, not strict JSON (some keys are unquoted), so the
    IDs/names are read with a regex per object instead of json.loads().
    """
    items: dict[int, str] = {}
    idx = page_html.find("var listviewitems")
    if idx == -1:
        return items
    block = extract_balanced(page_html, idx, "[", "]")
    if not block:
        return items

    pos = 1  # skip the opening '['
    while True:
        text = extract_balanced(block, pos, "{", "}")
        if not text:
            break
        pos = block.find(text, pos) + len(text)
        # Drop nested objects so only top-level keys are matched.
        top_level = text
        while True:
            reduced = top_level[0] + re.sub(r"\{[^{}]*\}", "{}", top_level[1:-1]) + top_level[-1]
            if reduced == top_level:
                break
            top_level = reduced
        text = top_level
        id_match = re.search(r'"id"\s*:\s*(\d+)', text)
        if not id_match:
            continue
        name_match = re.search(r'"name"\s*:\s*"((?:[^"\\]|\\.)*)"', text)
        name = json.loads(f'"{name_match.group(1)}"') if name_match else "Unknown item"
        items[int(id_match.group(1))] = name
    return items


def extract_items(page_html: str) -> dict[int, str]:
    listview = extract_listview_items(page_html)
    gatherer = extract_gatherer_items(page_html)

    # The listview is the authoritative filter result; Gatherer supplies names.
    ids = set(listview) or set(gatherer)
    merged = {i: gatherer.get(i) or listview.get(i) or "Unknown item" for i in ids}

    if listview and gatherer and set(listview) != set(gatherer):
        extra = sorted(set(gatherer) - set(listview))
        missing = sorted(set(listview) - set(gatherer))
        if extra:
            print(f"    note: {len(extra)} Gatherer-only item(s) ignored: {extra[:10]}")
        if missing:
            print(f"    note: {len(missing)} listview item(s) had no Gatherer name")

    return dict(sorted(merged.items(), reverse=True))


# --------------------------------------------------------------------------
# Lua output
# --------------------------------------------------------------------------
def lua_table_key(table_name: str) -> str:
    if re.fullmatch(r"[A-Za-z_][A-Za-z0-9_]*", table_name):
        return f"items.{table_name}"
    escaped = table_name.replace("\\", "\\\\").replace('"', '\\"')
    return f'items["{escaped}"]'


def lua_comment(text: str) -> str:
    return html.unescape(text).replace("\r", " ").replace("\n", " ").strip()


def build_lua(results: "OrderedDict[str, list[tuple[Entry, dict[int, str]]]]") -> str:
    lines = [
        "-- Generated by wowhead_to_item_tables.py",
        f"-- Generated at {time.strftime('%Y-%m-%d %H:%M:%S')}",
        "",
    ]
    for table_name, sections in results.items():
        lines.append(f"{lua_table_key(table_name)} = {{")
        for entry, items in sections:
            lines.append(f"    -- {entry.url}")
            lines.append(f"    [{entry.expansion_number}] = {{ -- {entry.expansion_name}")
            for item_id, name in items.items():
                lines.append(f"        {item_id}, -- {lua_comment(name)}")
            lines.append("    },")
        lines.append("}")
        lines.append("")
    return "\n".join(lines)


# --------------------------------------------------------------------------
# Main
# --------------------------------------------------------------------------
def main() -> int:
    input_file = Path(sys.argv[1]).resolve() if len(sys.argv) > 1 else DEFAULT_INPUT
    if len(sys.argv) > 2:
        output_file = Path(sys.argv[2]).resolve()
    elif len(sys.argv) > 1:
        output_file = input_file.with_suffix(".lua")
    else:
        output_file = DEFAULT_OUTPUT

    print(f"Input : {input_file}")
    print(f"Output: {output_file}\n")

    if not input_file.exists():
        print(f"ERROR: input file not found: {input_file}")
        return 1

    try:
        entries = read_input_file(input_file)
    except ValueError as error:
        print(f"ERROR in input file:\n{error}")
        return 1

    if not entries:
        print("ERROR: no entries found in input file.")
        return 1

    results: "OrderedDict[str, list[tuple[Entry, dict[int, str]]]]" = OrderedDict()
    failures = 0

    for index, entry in enumerate(entries):
        if index:
            time.sleep(REQUEST_DELAY_SECONDS)

        print(f"[{index + 1}/{len(entries)}] {entry.table_name} "
              f"[{entry.expansion_number}] {entry.expansion_name}")
        print(f"    {entry.url}")

        try:
            page_html = download_page(entry.url)
        except RuntimeError as error:
            print(f"    FAILED: {error}")
            failures += 1
            continue

        items = extract_items(page_html)
        if not items:
            print("    WARNING: no items found (page layout may have changed).")
        else:
            print(f"    Found {len(items)} item(s).")
        if len(items) >= WOWHEAD_LIST_LIMIT:
            print(f"    WARNING: {len(items)} results - Wowhead caps lists at "
                  f"{WOWHEAD_LIST_LIMIT}. Narrow the filter to avoid missing items.")

        results.setdefault(entry.table_name, []).append((entry, items))

    if results:
        output_file.write_text(build_lua(results), encoding="utf-8")
        print(f"\nLua written to: {output_file}")

    if failures:
        print(f"\n{failures} entr{'y' if failures == 1 else 'ies'} failed.")
        return 2
    return 0


if __name__ == "__main__":
    sys.exit(main())
