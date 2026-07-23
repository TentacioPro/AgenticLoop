---
type: Artifact
title: specs/tasks/00-spec-system.md (target file)
description: The core process definition — six-step loop, escalation rules, templates.
tags: [artifact, target-file, core]
target-path: specs/tasks/00-spec-system.md
consumes: [all-questions]
---
# Artifact: 00-spec-system.md

## Purpose
The one file that governs how tasks flow from ask to merge. Project-agnostic;
tailored only by inserting the answered questions' choices into the "Standing
constraints" section.

## Skeleton to emit
Sections:
1. Overview — the three-actor pattern (specs govern, agents execute, owner
   decides at branch points).
2. The six-step loop (read → red → green → gate → record → update).
3. Task spec template (see [task-spec artifact](task-spec.md)).
4. State file template (see [state-file artifact](state-file.md)).
5. Decisions file rules (see [decisions-log artifact](decisions-log.md)).
6. Escalation rules — when the agent MUST stop and ask the owner.
7. Standing constraints — filled from Phase 1 answers (stack, verify cadence).
8. Failure modes reference —
   [memory/failure-modes](../memory/failure-modes.md) is where these live.

## Rules
- The escalation rules section is not customizable — the same 10 rules apply
  in every project (weaken-a-test = stop, ambiguous GOAL = stop, etc.).
- The templates section MUST match the exact templates in
  [task-spec](task-spec.md) and [state-file](state-file.md) — no divergent
  copies.
