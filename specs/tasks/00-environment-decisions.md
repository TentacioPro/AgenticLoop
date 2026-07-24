---
type: DecisionsLog
title: Environment & Methodology Decisions
description: Append-only log of every environment/methodology decision made during and after bootstrap.
provenance: bootstrap-skill-0.1.0
source-answers: []
---
# 00-environment-decisions.md

Append-only. Corrections are new numbered entries that reference the old
number — never edit a prior entry in place.

## Decision 1: Branch Strategy
Chosen: All AgenticLoop v2 bootstrap work happens on branch `v2` (cut from `main`), and all future setup-agent sessions for this bootstrap continue on `v2` or branches cut from it.
Rejected:
- Work directly on `main` — no isolation between in-progress bootstrap state and the stable default branch.
- One feature branch per phase (context-scan/grill/tailor/verify each on its own branch) — unnecessary overhead for a single coherent bootstrap effort; `v2` already isolates it from `main`.
Rationale: Explicit owner instruction — "git checkout -b v2 (from the default branch). All work in this session and all future agent sessions for this setup happen on v2 or branches cut from it."
Recorded: 2026-07-24T00:00:00Z
