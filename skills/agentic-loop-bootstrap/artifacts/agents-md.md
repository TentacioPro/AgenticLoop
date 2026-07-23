---
type: Artifact
title: AGENTS.md (target file)
description: The vendor-neutral entry point every coding agent reads first, emitted at repo root.
tags: [artifact, target-file]
target-path: AGENTS.md
consumes: [existing-repo, harness]
---
# Artifact: AGENTS.md

## Purpose
Any agent (Claude Code, Kimi, OpenClaw, custom) opens this file first and
knows what to do. Vendor-neutral by construction.

## Template (fill from Phase 1 answers)
```markdown
# AGENTS.md — vendor-neutral entry point

You are working in <PROJECT_NAME>. Before any tool call:

1. Read `specs/tasks/00-spec-system.md` — the process, non-negotiable.
2. Read `specs/tasks/00-environment-decisions.md` — the settled choices.
3. Find your task's state file: `specs/tasks/<NN>-<name>.state.md`.
4. Follow the six-step loop: read → red → green → gate → record → update.
5. Work ONLY inside your task's FILE SCOPE.
6. Never claim something works without pasted test output.
7. Never overwrite decisions. Corrections happen as new numbered entries.

Stack: <FROM stack QUESTION>
Harness expectation: <FROM harness QUESTION>
Threat model: <FROM threat-model QUESTION>

Escalate to owner if any rule in `specs/tasks/00-spec-system.md` §escalation
would be violated by proceeding.
```

## Rules for emission
- Never overwrite an existing AGENTS.md silently. If present, diff and ask.
- If the harness answer includes multiple agents, list all in "Harness
  expectation" — separated by commas.
- Never inline the full spec system into this file. It's a pointer, not a
  copy. See [principle: no drift via duplication](../principles/append-only.md).
