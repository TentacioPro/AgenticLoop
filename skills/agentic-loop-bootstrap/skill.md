---
type: Skill
title: AgenticLoop Bootstrap
description: Set up the AgenticLoop methodology in any project through incremental grilling and evidence-verified emission.
resource: https://github.com/TentacioPro/AgenticLoop
tags: [skill, bootstrap, okf, methodology]
version: 0.1.0
requires:
  - filesystem-write
  - filesystem-read
  - shell
triggers:
  - "bootstrap agentic loop"
  - "set up agentic loop here"
  - "install agentic loop"
---

# Skill: AgenticLoop Bootstrap

## When to invoke
The user says one of the trigger phrases OR the user is in an empty/near-empty
directory and asks how to start applying the methodology.

## What this skill does
Runs a four-phase bootstrap:

1. **[Context scan](phases/00-context-scan.md)** — read what already exists
   (repo? language? existing specs? existing AGENTS.md?).
2. **[Grill](phases/01-grill.md)** — ask the user 5–9 questions incrementally,
   ONE at a time, each with options. Never bulk-dump.
3. **[Tailor](phases/02-tailor.md)** — generate AGENTS.md, CLAUDE.md,
   .claude/settings.json, specs/tasks/00-spec-system.md,
   specs/tasks/00-environment-decisions.md — each tailored to the answers.
4. **[Verify](phases/03-verify.md)** — run a minimal proof (write a throwaway
   task spec, follow the six-step loop for it, confirm the setup works
   end-to-end before declaring done).

## Behavioral rules (binding for every invocation)

1. **Grill, don't dump.** ONE question per turn. Wait for the answer. Never
   present the whole questionnaire at once — that's the failure mode this
   skill exists to avoid.
2. **Every answer is a [decision](principles/append-only.md).** The moment the
   user answers, the choice + rejected alternatives + rationale get appended
   to `specs/tasks/00-environment-decisions.md`. If the user changes their
   mind later, that's a new decision — never edit the old one.
3. **Verify before act.** Before generating any file, read what's already at
   that path. If the file exists and differs from what you'd write, STOP and
   ask — never overwrite silently. This is
   [verify-then-act](principles/verify-then-act.md).
4. **Honest scope.** If the user's project is a case the methodology hasn't
   been validated on (see [memory/lessons-from-real-use](memory/lessons-from-real-use.md)),
   say so before proceeding. "This has been validated on X, not Y — do you
   want to proceed anyway?" is a valid checkpoint.
5. **Provenance labels on emitted files.** Every generated file's frontmatter
   includes `provenance: bootstrap-skill-<version>` and `source-answers: [q1,
   q2, ...]` so a later reader can trace every choice back to a specific
   answer given by the owner.
6. **Escape hatches.** At any point the user can say `pause`, `back`, or
   `commit what we have so far`. The skill respects each: `pause` writes
   partial state to `specs/tasks/BOOTSTRAP-progress.md`; `back` undoes the
   last decision (records the undo, doesn't delete the record); `commit what
   we have so far` emits what's decided and marks the rest as
   `deferred`-status decisions for later.
7. **No hallucinated defaults.** When the user says "just use the defaults,"
   the skill lists what those defaults are BEFORE applying them, and gets
   explicit go. Silent defaults are how methodology drift starts.

## Success criteria
Bootstrap is complete when:
- All 5 core artifacts exist in the repo (see
  [phase 02 tailor](phases/02-tailor.md))
- `specs/tasks/00-environment-decisions.md` has one entry per answered question
- The verification pass in [phase 03](phases/03-verify.md) succeeds — a
  throwaway task spec was written, followed the six-step loop, gated green,
  and the state file is populated
- The user has said `bootstrap complete` explicitly (not the skill's
  assumption)

## Failure modes (stop and escalate, do not proceed)
- User's project is in a language the [threat model question](questions/threat-model.md)
  can't be sanely defaulted for (WASM sandbox, kernel module, cryptography
  library) — surface the mismatch, do not guess.
- Existing `.claude/settings.json` in the repo already blocks the writes this
  skill needs — surface the conflict, do not attempt to bypass permissions.
- User answers a question with content that suggests a fundamentally different
  methodology is being asked for (e.g. answers imply pure vibe-coding is the
  goal) — this bundle is not the right fit; say so and stop.

## References
- [Principle: Provenance before confidence](principles/provenance-before-confidence.md)
- [Principle: State lives in the repo](principles/state-in-repo.md)
- [Memory: Failure modes](memory/failure-modes.md)
- [Example: A full bootstrap walkthrough](examples/walkthrough.md)
