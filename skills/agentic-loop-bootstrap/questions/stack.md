---
type: Question
title: Primary Stack
description: One of the grill questions asked in Phase 1.
tags: [question, grill]
answer-shape: single-choice
options: [python,typescript-node,mixed,other]
---
# Question: Primary Stack

## Ask this way
Present ONE prompt to the user, list the options with a brief gloss for each,
and wait for a single choice.

## Why this matters
See [Phase 1 grill](../phases/01-grill.md) — the answer directly shapes the
[.claude/settings.json](../artifacts/settings-json.md) permission profile and
the initial [spec-system](../artifacts/spec-system.md) task ledger.

## Options + implications
- **python** — see decision-implications table in the artifact that consumes this answer.
- **typescript-node** — see decision-implications table in the artifact that consumes this answer.
- **mixed** — see decision-implications table in the artifact that consumes this answer.
- **other** — see decision-implications table in the artifact that consumes this answer.

## Default (if user says "just pick sensibly")
The FIRST option in the list. State it explicitly before applying:
"I'll default to `python` — confirm?" No silent defaults.

## Record as
```
## Decision N: Primary Stack
Chosen: <option>
Rejected: <the others, each with one-line reason not to pick>
Rationale: <user's stated reason, or "not provided">
Recorded: <ISO 8601 timestamp>
```
