---
provenance: bootstrap-skill-0.1.0
source-answers: [stack:other, threat-model:solo-public-repo]
---
# NN — <Task name>

## GOAL
One concrete, checkable outcome. Not a direction.

## MODULE SPECS IN SCOPE
Which spec files govern this work. Read them first.

## REUSE MAP (mandatory)
| Existing asset | Where (verified path) | How it's reused |
|---|---|---|

Every path must be verifiable by `ls`. "Derive from spec" only after explicit
owner confirmation the source file doesn't exist.

## TDD CONTRACT
1. Tests to write FIRST (names + assertions). Red before green.
2. Existing tests that must stay green (name the suites).

## FILE SCOPE
Exact directories/files this task may touch. Anything outside = violation.

## OUT OF SCOPE
Explicitly.

## DONE MEANS
- [ ] All TDD-contract tests green
- [ ] Full gate on merge-result commit before push
- [ ] NN-decisions.md written with rejected alternatives
- [ ] State file populated
