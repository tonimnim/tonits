#!/usr/bin/env python3
"""Merges lib/l10n/parts/*.json into lib/l10n/app_en.arb.

Each fragment is an ARB object: "key": "text" plus optional "@key"
metadata. Keys must be unique across fragments.
"""
import glob
import json
import os
import sys

root = os.path.join(os.path.dirname(__file__), '..', 'lib', 'l10n')
merged = {'@@locale': 'en'}
owner = {}
for path in sorted(glob.glob(os.path.join(root, 'parts', '*.json'))):
    with open(path, encoding='utf-8') as f:
        part = json.load(f)
    for key, value in part.items():
        if key in merged and not key.startswith('@@'):
            sys.exit(f'{key} is in both {owner[key]} and {os.path.basename(path)}')
        merged[key] = value
        owner[key] = os.path.basename(path)
with open(os.path.join(root, 'app_en.arb'), 'w', encoding='utf-8') as f:
    json.dump(merged, f, ensure_ascii=False, indent=2)
    f.write('\n')
print(f'{sum(1 for k in merged if not k.startswith("@"))} strings')
