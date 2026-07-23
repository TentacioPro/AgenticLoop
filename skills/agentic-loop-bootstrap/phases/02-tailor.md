---
type: Phase
title: Tailor
description: Generate the setup files from the answers gathered in Phase 1.
tags: [phase, bootstrap, generation]
order: 2
---
# Phase 2: Tailor

## Goal
Emit the methodology's core artifacts, each tailored to the answers.

## Files to generate (in this order — earlier files inform later)
1. [AGENTS.md](../artifacts/agents-md.md) at repo root — vendor-neutral entry.
2. [CLAUDE.md](../artifacts/claude-md.md) at repo root — one-line pointer.
3. [.claude/settings.json](../artifacts/settings-json.md) — permission profile
   from [threat-model](../questions/threat-model.md) answer.
4. [specs/tasks/00-spec-system.md](../artifacts/spec-system.md) — the process
   definition, project-agnostic.
5. [specs/tasks/00-environment-decisions.md](../artifacts/decisions-log.md) —
   already populated by Phase 1; final section added here.
6. [specs/tasks/TEMPLATE-task.md](../artifacts/task-spec.md) — the template.
7. [specs/tasks/TEMPLATE-state.md](../artifacts/state-file.md) — the state template.

## Rules
- Every file's frontmatter includes `provenance: bootstrap-skill-0.1.0` and
  `source-answers: [q1-answer, q2-answer, ...]`.
- If the file exists at target path and differs from what would be written,
  STOP — ask the user: overwrite? extend? skip?
- Never overwrite `.env`, secrets, or anything under `.git/`.
- Emit files one at a time. Show the user each file's path + first 10 lines
  before writing.

## Exit
When all 7 files are written, invoke [Phase 3: Verify](03-verify.md).
