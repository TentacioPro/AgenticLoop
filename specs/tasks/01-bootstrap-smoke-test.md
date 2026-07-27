---
provenance: bootstrap-skill-0.1.0
source-answers: [verify-cadence:phase-boundary]
---
# 01 — Bootstrap smoke test

## GOAL
Add a single-line file `.agenticloop-installed` at the repo root containing
today's date. No other change. Merge on green.

## MODULE SPECS IN SCOPE
- `specs/tasks/00-spec-system.md` — the six-step loop this task follows.
- `specs/tasks/00-environment-decisions.md` — the settled environment choices
  this smoke test is validating end-to-end.

## REUSE MAP (mandatory)
| Existing asset | Where (verified path) | How it's reused |
|---|---|---|
| Six-step loop definition | `specs/tasks/00-spec-system.md` §2 | Followed step-by-step for this task |
| Environment decisions | `specs/tasks/00-environment-decisions.md` | Read before acting, per AGENTS.md step 1-2 |
| Knowledge graph | `graphify-out/graph.json` | Queried once as gate evidence (graph-before-grep rule) |

## TDD CONTRACT
1. Tests to write FIRST: a shell assertion that `.agenticloop-installed`
   exists and its content equals today's date in `YYYY-MM-DD` form. Must
   fail (red) before the file is created.
2. Existing tests that must stay green: none exist in this repo (stack =
   Other, per Decision 4) — nothing to regress.

## FILE SCOPE
- `.agenticloop-installed` (create)
- `specs/tasks/01-bootstrap-smoke-test.md` (this file)
- `specs/tasks/01-bootstrap-smoke-test-decisions.md`
- `specs/tasks/01-bootstrap-smoke-test.state.md`

## OUT OF SCOPE
Any other file. No changes to `AGENTS.md`, `.claude/settings.json`, or any
other Tailor-phase artifact as part of this task.

## DONE MEANS
- [ ] All TDD-contract tests green
- [ ] Full gate on merge-result commit before push
- [ ] 01-bootstrap-smoke-test-decisions.md written with rejected alternatives
- [ ] State file populated, including one `/graphify query` result as gate evidence
