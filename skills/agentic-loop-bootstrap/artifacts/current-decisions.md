---
type: Artifact
title: specs/tasks/CURRENT_DECISIONS.md (target file)
description: Short, always-read live view of the decisions ledger. Not append-only — a maintained summary.
tags: [artifact, target-file, decisions]
target-path: specs/tasks/CURRENT_DECISIONS.md
consumes: [all-questions]
---
# Artifact: CURRENT_DECISIONS.md

## Purpose
`AGENTS.md` sends every session to this file instead of the full
append-only ledger (`00-environment-decisions.md`). The ledger is the
source of truth for reasoning and history; this file only ever answers
"what applies right now" — one line per decision still in force, each
pointing back at its ledger entry for the full rationale. This is the
fix for the failure mode where a growing append-only log becomes most of
every session's mandatory read path (see `docs/validation-plan.md` §1).

## Emission
Generated in Phase 2 (Tailor), immediately after
[`00-environment-decisions.md`](decisions-log.md): one line per Phase-1
decision, in the same order as the ledger. Template:

```markdown
---
type: DecisionsCurrentView
title: Current decisions (live view)
description: Short list of decisions still in force. Full rationale, rejected alternatives and timestamps are in the append-only ledger; read that only when this view isn't enough.
provenance: bootstrap-skill-<version>
---
# CURRENT_DECISIONS.md — read this, not the full ledger, by default

Full ledger (append-only, rejected alternatives, exact rationale, ISO timestamps): `00-environment-decisions.md`.
Read the ledger only when you need a decision's reasoning or history — not as part of every session's mandatory read path.

- **<Decision topic>:** <one-line chosen answer>. — Decision <N>
<repeat per Phase-1 decision>
```

## Rules
- Not append-only. See [principle: append-only](../principles/append-only.md)
  for the contrast — this file is the one deliberate exception, because it
  exists to be edited, not to preserve history.
- Whoever appends a ledger entry updates this file in the same step (or
  explicitly decides the entry doesn't change what's "current" and leaves
  this file alone) — see the pairing rule in
  [decisions-log.md](decisions-log.md).
- Keep it short: one line per decision, no rationale, no rejected
  alternatives — those stay in the ledger. If this file creeps past
  roughly 30-40 lines, that's a signal to retire the oldest
  fully-superseded entries out of it (they stay in the ledger regardless),
  not to let it grow indefinitely.
- Never hand-summarize from memory — every line here traces to a real
  ledger entry number.
