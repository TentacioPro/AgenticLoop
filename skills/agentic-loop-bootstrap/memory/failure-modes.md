---
type: Memory
title: Named failure modes
description: Traps that were hit or nearly hit in real use. Each has a name so it can be recognized fast.
tags: [memory, failure-modes]
---
# Memory: Named failure modes

## The Ghost Test
**Symptom:** Test suite reports N passing; reality is fewer tests actually
run because some suites fail to load and their tests never register.
**Detection:** Compare test count against source truth (grep for `def
test_` / `it(` / `test(`).
**Recovery:** Fix the mock/setup issue causing suite-load failures; recount.
The "reveal 53 hidden tests" incident is the archetype.

## The Trunk-Merge-With-Pending-Gate
**Symptom:** Tasks merged to trunk with integration gates marked
`gate_pending` for reasons like "no live server" — when starting the server
is in the allowlist.
**Detection:** Any state file with status `done` and `last_verified`
missing the full gate output.
**Recovery:** Never merge without gate. Codify as an explicit rule the
first time it happens, not the third.

## The Word-Grep Overreach
**Symptom:** A test that scans source for forbidden words fires on
legitimate documentation using those words.
**Detection:** Test error message quotes docstring content, not code.
**Recovery:** Replace with AST-based inspection: parse the module, assert
on structure (no `os.environ` reads in permission paths, no `if` on env
values in decision code), let comments say anything.

## The Silent Overwrite
**Symptom:** A generation step overwrites a file the user had edited,
without warning.
**Detection:** User says "I made a change and it's gone."
**Recovery:** Every write action reads target path first. If exists and
differs, STOP and ask. This is the [verify-then-act](../principles/verify-then-act.md)
principle failing.

## The Fake Completion
**Symptom:** Agent reports "completed" for work the permission layer
actually blocked, or claims tests passed without pasted output.
**Detection:** Read the artifact instead of the report. `ls`. Run the test.
**Recovery:** Never trust "completed" without a verifiable artifact. State
files require pasted test output as `last_verified` for this reason.

## The Environment Masquerade
**Symptom:** Something looks like a bug in the code but is actually an
environment issue (missing mock, wrong port, stale dotenv, PATH issue).
**Detection:** Symptoms don't match the code's obvious behavior.
**Recovery:** Verify tooling before "fixing" code. Every environment
failure masquerading as claim-inflation goes here.
