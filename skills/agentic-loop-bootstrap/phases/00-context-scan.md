---
type: Phase
title: Context Scan
description: Read what's already in the target directory before asking any questions.
tags: [phase, bootstrap]
order: 0
---
# Phase 0: Context Scan

## Goal
Know what's in the directory before generating anything.

## Actions (in order)
1. `ls -la` at repo root — list everything including dotfiles.
2. `git status` — is this a git repo? clean? on what branch?
3. Read (if present): `README.md`, `package.json`, `pyproject.toml`,
   `Cargo.toml`, `go.mod`, `Gemfile`, `AGENTS.md`, `CLAUDE.md`,
   `.claude/settings.json`, any `specs/` directory contents.
4. `git remote -v` — is there an origin? public or private?

## Output
A one-paragraph summary sent to the user:
> "I'm looking at `<path>`. This is a `<language/framework>` project on
> branch `<branch>`, remote `<remote>`. I found existing:
> <list of methodology-relevant files>. I did NOT find:
> <list of missing pieces>."

Then invoke [Phase 1: Grill](01-grill.md).

## Rules
- Never modify anything in this phase — read-only.
- If a critical file exists (AGENTS.md, .claude/settings.json), FLAG it —
  the user needs to decide whether we're bootstrapping fresh or extending.
- No assumptions about intent yet — just report the terrain.
