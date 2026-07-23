---
type: Question
title: Coding Agent Harness
description: One of the grill questions asked in Phase 1.
tags: [question, grill]
answer-shape: single-choice
options: [claude-code,kimi,openclaw,mixed-multi-agent,unknown]
---
# Question: Coding Agent Harness

## Ask this way
Present ONE prompt to the user, list the options with a brief gloss for each,
and wait for a single choice.

## Why this matters
See [Phase 1 grill](../phases/01-grill.md) — the answer directly shapes the
[.claude/settings.json](../artifacts/settings-json.md) permission profile and
the initial [spec-system](../artifacts/spec-system.md) task ledger.

## Options + implications
- **claude-code** — see decision-implications table in the artifact that consumes this answer.
- **kimi** — see decision-implications table in the artifact that consumes this answer.
- **openclaw** — see decision-implications table in the artifact that consumes this answer.
- **mixed-multi-agent** — see decision-implications table in the artifact that consumes this answer.
- **unknown** — see decision-implications table in the artifact that consumes this answer.

## Default (if user says "just pick sensibly")
The FIRST option in the list. State it explicitly before applying:
"I'll default to `claude-code` — confirm?" No silent defaults.

## Record as
```
## Decision N: Coding Agent Harness
Chosen: <option>
Rejected: <the others, each with one-line reason not to pick>
Rationale: <user's stated reason, or "not provided">
Recorded: <ISO 8601 timestamp>
```
