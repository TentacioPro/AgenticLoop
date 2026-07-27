---
provenance: bootstrap-skill-0.1.0
source-answers: [verify-cadence:phase-boundary]
---
# 01-bootstrap-smoke-test-decisions.md

Append-only, scoped to task 01. Corrections are new numbered entries.

## Decision 1: Smoke-test scope
Chosen: Exactly as specified by Phase 3 — create `.agenticloop-installed` at
repo root containing today's date, nothing else.
Rejected:
- A richer smoke test (e.g. exercising the graph query as part of the red/
  green cycle itself) — rejected because the task's own GOAL is deliberately
  minimal; the graphify-query evidence is gate-augmentation, not part of the
  file-creation TDD contract.
Rationale: Follows `skills/agentic-loop-bootstrap/phases/03-verify.md` exactly.
Recorded: 2026-07-27T00:00:00Z

## Decision 2: graphify binary resolution for gate evidence
Chosen: Invoke the shared top-root venv's binary explicitly
(`/e/.venv-graphify/Scripts/graphify.exe`) with `PYTHONIOENCODING=utf-8`, for
the gate-evidence query.
Rejected:
- Bare `graphify` on PATH — resolves to a separate `uv tool install` at
  version 0.6.7 (older than the shared venv's graphify 0.9.25 from
  Decision 2 in `00-environment-decisions.md`), and additionally hit a
  `UnicodeEncodeError` on Windows' default cp1252 console encoding when
  printing an arrow character (`→`) in a node label.
Rationale: The shared venv is the methodology's declared source of truth for
graphify (Decision 2, `00-environment-decisions.md`); using the stale PATH
binary would silently diverge from that decision and also fails outright on
Windows console encoding.
Deviation note: this PATH/version split (bare `graphify` != shared venv
`graphify`) should be flagged to the owner as a follow-up — it's easy for a
future session to run the wrong binary and get a stale/broken result.
Recorded: 2026-07-27T00:00:00Z
