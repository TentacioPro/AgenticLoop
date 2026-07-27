---
provenance: bootstrap-skill-0.1.0
source-answers: [stack:other, verify-cadence:phase-boundary, threat-model:solo-public-repo, existing-repo:greenfield]
---
# 00-spec-system.md — the process, non-negotiable

## 1. Overview
Three actors, three responsibilities:
- **Specs govern.** `specs/tasks/*.md` is the source of truth for what a
  task is allowed to do. An agent that disagrees with a spec escalates; it
  does not silently reinterpret it.
- **Agents execute.** Coding agents (Claude Code, Kimi, OpenClaw, or others —
  see `AGENTS.md`) do the work, one task at a time, inside that task's FILE
  SCOPE only.
- **Owner decides at branch points.** Anything ambiguous, anything that
  weakens a test, anything that crosses a FILE SCOPE or a contract boundary —
  the owner decides, not the agent.

## 2. The six-step loop
Every task moves through these steps, in order, every time:
1. **read** — read the task spec, the decisions log, and the current state
   file before touching anything.
2. **red** — write the test(s) that currently fail (TDD contract), and show
   the failing output.
3. **green** — make the minimum change that turns red to green.
4. **gate** — run the full relevant test suite (not just the new test) and
   paste the output. A claim without pasted output is not verified.
5. **record** — append a decision entry (with rejected alternatives) to the
   task's own decisions file, or to `00-environment-decisions.md` for
   environment/methodology-level decisions.
6. **update** — update the task's state file (`specs/tasks/<NN>-<name>.state.md`)
   with `status`, `loop_step`, `last_verified` (pasted output), and
   `next_action`.

## 3. Task spec template
See `specs/tasks/TEMPLATE-task.md`. Every numbered task file
(`specs/tasks/NN-<name>.md`) follows this exact structure — GOAL, MODULE
SPECS IN SCOPE, REUSE MAP, TDD CONTRACT, FILE SCOPE, OUT OF SCOPE, DONE MEANS.

## 4. State file template
See `specs/tasks/TEMPLATE-state.md`. Every task's state file
(`specs/tasks/NN-<name>.state.md`) follows this exact structure and is
updated at every loop-step boundary, committed with the code.

## 5. Decisions file rules
`specs/tasks/00-environment-decisions.md` is append-only. Every entry has:
title, chosen, rejected (each with a one-line reason), rationale, ISO 8601
timestamp. Corrections are new numbered entries referencing the old number —
never an edit in place. See the decisions-log rules baked into that file's
own header.

## 6. Escalation rules (not customizable — same in every project)
Stop and ask the owner if, and only if, one of these is true:
1. A change would weaken, skip, or delete an existing passing test.
2. The task's GOAL is ambiguous enough that two reasonable readings produce
   different FILE SCOPEs.
3. The work would touch a file outside the task's declared FILE SCOPE.
4. The work would cross a contract boundary into a sibling repo (see
   `AGENTS.md` §Contract-boundary rule) instead of staying inside this repo.
5. A REUSE MAP entry claims a path that does not actually exist on disk.
6. The gate step fails and the fix isn't a one-line, obviously-correct change.
7. A decision would need to be "corrected" by editing a past entry instead of
   appending a new one.
8. Secrets, credentials, or `.env` contents would need to be read, printed,
   or committed.
9. A destructive git/filesystem operation (force-push, hard reset, recursive
   force-delete, branch `-D`) seems like the fastest way to unblock progress.
10. The owner's stated verify-cadence (phase-boundary, per Decision 7) would
    be skipped — i.e., proceeding straight through a phase boundary without
    reporting status first.

## 7. Standing constraints (from Phase 1 answers)
- **Stack:** Other — this repo is a markdown / OKF / skill-definition
  bundle. No application test runner exists in this repo itself; the TDD
  contract in task specs applies to any code this methodology is later used
  to build, not to this repo's own (nonexistent) source.
- **Verify cadence:** Phase boundary — the owner checks in at the end of
  each phase (context-scan, grill, tailor, verify) rather than at every
  merge or only rarely. Do not silently cross a phase boundary.
- **Threat model:** Solo public repo — see `.claude/settings.json` and
  `.claude/settings.rationale.md` for the resulting permission profile.
- **Harness:** Mixed / multi-agent — `AGENTS.md` is the vendor-neutral
  source of truth; do not duplicate its content into harness-specific files.

## 8. Failure modes reference
See `skills/agentic-loop-bootstrap/memory/failure-modes.md` for the catalog
of known failure modes this methodology guards against (if present in this
checkout — it ships with the `agentic-loop-bootstrap` skill itself).
