---
type: Phase
title: Verify
description: Prove the setup works by running a throwaway task through the six-step loop.
tags: [phase, bootstrap, verification]
order: 3
---
# Phase 3: Verify

## Goal
Do not declare bootstrap done until the setup has actually been used once,
end-to-end.

## The throwaway task
Generate `specs/tasks/01-bootstrap-smoke-test.md` with GOAL:
> "Add a single-line file `.agenticloop-installed` at the repo root containing
> today's date. No other change. Merge on green."

Then execute the six-step loop for that task:
1. **Read** — the task spec (just generated)
2. **Red** — write one test (a shell command that checks for the file's
   existence and today's date content)
3. **Green** — create the file
4. **Gate** — run the test
5. **Record** — write `specs/tasks/01-bootstrap-smoke-test-decisions.md`
6. **Update** — populate `specs/tasks/01-bootstrap-smoke-test.state.md`

## Success criteria
- The .agenticloop-installed file exists
- The test passes
- All artifacts from Phase 2 are populated
- User confirms `bootstrap complete`

## On failure
If any step fails, do NOT declare bootstrap done. Record the failure in
`specs/tasks/00-environment-decisions.md` as a deviation, describe the
failure mode from [memory/failure-modes.md](../memory/failure-modes.md) if it
matches a known one, and stop for user decision.

## Cleanup
The user chooses:
- `keep smoke test` — commits the smoke-test artifacts as first task history
- `remove smoke test` — deletes `.agenticloop-installed` and the task files,
  keeps only the environment setup
Either is fine. Recording which was chosen is what matters.
