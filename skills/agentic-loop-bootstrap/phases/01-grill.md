---
type: Phase
title: Grill
description: Ask 5-9 questions ONE at a time, record each answer as a decision.
tags: [phase, bootstrap, grill]
order: 1
---
# Phase 1: Grill

## Goal
Get the specific answers needed to tailor the methodology to this project.

## Method
Ask ONE question per turn. Wait for answer. Record decision. Ask next.
Never bulk-present.

## The question sequence
Adapt to context; skip questions already answered by Phase 0's scan.

1. [existing-repo](../questions/existing-repo.md) — greenfield or brownfield?
2. [stack](../questions/stack.md) — primary language / framework / test runner
3. [harness](../questions/harness.md) — Claude Code, Kimi, OpenClaw, hybrid?
4. [threat-model](../questions/threat-model.md) — solo local, team, public repo
5. [verify-cadence](../questions/verify-cadence.md) — how often does the owner
   inspect vs. trust
6. Optional depending on above:
   - CI system in use (GitHub Actions, GitLab, other)
   - Existing testing baseline (a count = a claim; verify before trusting)
   - Deployment target (matters for `.env` and secrets policy)

## For each question
1. Present the question + options (from the question's `.md` file).
2. Wait for answer.
3. Append to `specs/tasks/00-environment-decisions.md`:
   ```
   ## Decision N: <question title>
   Chosen: <answer>
   Rejected: <the other options + one-line reason each>
   Rationale: <user's stated reason, or "not provided">
   Recorded: <timestamp>
   ```
4. Ask next question.

## Escape hatches user can invoke
- `pause` — write partial state to `BOOTSTRAP-progress.md`, stop
- `back` — undo last decision (record the undo)
- `commit what we have so far` — proceed to Phase 2 with defaults for
  remaining questions, mark them `deferred`

## Exit
When all questions are answered (or explicitly deferred), invoke
[Phase 2: Tailor](02-tailor.md).
