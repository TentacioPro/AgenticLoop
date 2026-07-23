---
type: Example
title: A full bootstrap walkthrough
description: Fully invented example showing the skill running end-to-end on a hypothetical project.
tags: [example, walkthrough]
provenance: fully-invented — no real project data
---
# Example: Bootstrap Walkthrough

*Everything below is invented. Names, choices, project details — all fictional
for illustration.*

## Setup
User has an empty directory `~/projects/hexnote` where they want to start a
personal note-taking tool. They've cloned agentic-loop-bootstrap into
`.claude/skills/`.

## Session

**User:** bootstrap agentic loop for this project

**Skill (Phase 0 — Context Scan):**
> Looking at `~/projects/hexnote`. Empty except for a fresh `git init` (branch
> main, no remote yet). Nothing methodology-relevant present. Ready to grill.

**Skill (Phase 1 — Q1: existing-repo):**
> Is this a fresh start or an existing project?
> - greenfield (empty, we're starting fresh)
> - brownfield-empty-specs (code exists, no methodology yet)
> - brownfield-partial-methodology (some spec files exist)
> - brownfield-competing-methodology (a different process is in use)

**User:** greenfield

**Skill:** *Appends Decision #1 to (draft) decisions log. Asks Q2.*

**Skill (Q2: stack):**
> Primary stack?
> - python
> - typescript-node
> - mixed
> - other

**User:** typescript-node

**Skill:** *Appends Decision #2. Asks Q3.*

**Skill (Q3: harness):**
> Which coding agent harness?
> - claude-code
> - kimi
> - openclaw
> - mixed-multi-agent
> - unknown

**User:** claude-code

**Skill:** *Decision #3. Asks Q4.*

**Skill (Q4: threat-model):**
> Threat model for this project?
> - solo-local (only you, only this machine)
> - solo-public-repo (only you, but the repo is public)
> - small-team
> - public-with-contributors

**User:** solo-public-repo

**Skill:** *Decision #4. Notes: settings.json will need extra denies for
secret-leak vectors. Asks Q5.*

**Skill (Q5: verify-cadence):**
> How often will you personally inspect vs. trust the agent?
> - every-merge (I look at every merge)
> - phase-boundary (only at phase milestones)
> - weekly (weekly reviews)
> - rare (I trust the gates; look only on breakage)

**User:** phase-boundary

**Skill:** *Decision #5. All 5 core questions answered. Proceeds to Phase 2.*

**Skill (Phase 2 — Tailor):**
> Emitting 7 files. I'll show each first line before writing.
>
> 1. `AGENTS.md` — vendor-neutral entry with stack: typescript-node...
> 2. `CLAUDE.md` — one-line pointer.
> 3. `.claude/settings.json` — solo-public-repo profile: [lists deny
>    additions including no cat *.env*, no external curl without allow-list].
> 4. `specs/tasks/00-spec-system.md` — process definition.
> 5. `specs/tasks/00-environment-decisions.md` — with 5 Phase-1 decisions
>    populated.
> 6. `specs/tasks/TEMPLATE-task.md`
> 7. `specs/tasks/TEMPLATE-state.md`
>
> Confirm before I write? Any changes?

**User:** looks good, write them

**Skill:** *Writes all 7. Shows the tree.*

**Skill (Phase 3 — Verify):**
> Running the smoke test. Generating `specs/tasks/01-bootstrap-smoke-test.md`
> with the throwaway "create `.agenticloop-installed`" task. Following the
> six-step loop now.
>
> - Read: done.
> - Red: created a bash check that greps for today's date in the target file.
>   Ran it — fails (file doesn't exist). Red confirmed.
> - Green: created `.agenticloop-installed` with today's date.
> - Gate: ran the check — passes.
> - Record: wrote `01-bootstrap-smoke-test-decisions.md`.
> - Update: populated state file.
>
> All 7 setup files + 3 smoke-test files present. Gate green. Confirm
> `bootstrap complete`?

**User:** bootstrap complete. Remove the smoke test artifacts, I don't need them
in history.

**Skill:** *Removes `.agenticloop-installed` and smoke-test files. Records the
removal as Decision #6 in environment-decisions log. Done.*

## What's in the repo after
```
hexnote/
├── AGENTS.md
├── CLAUDE.md
├── .claude/settings.json
└── specs/tasks/
    ├── 00-spec-system.md
    ├── 00-environment-decisions.md   ← contains 6 decisions incl. smoke cleanup
    ├── TEMPLATE-task.md
    └── TEMPLATE-state.md
```

The user's next real task starts as `specs/tasks/01-<something>.md` from the
template. The methodology is live.

## What the walkthrough demonstrates
- One question per turn, never bulk-dump
- Every answer becomes a decision immediately
- User is shown files before they're written
- Smoke test proves the setup actually works, not just "looks right"
- Cleanup choices (keep smoke test or remove) are themselves decisions
