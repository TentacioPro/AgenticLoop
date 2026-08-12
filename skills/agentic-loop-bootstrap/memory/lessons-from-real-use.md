---
type: Memory
title: Lessons from real use
description: What was learned across ~10 days of applying this methodology to a real project. Generic descriptions only — specifics belong to the source project.
tags: [memory, lessons]
provenance: extracted from ~9 sessions of validated use
scope: foundational backend security work + one design-decision phase
NOT-validated: data migration, agent orchestration, long-term maintenance, teams >1
---
# Memory: Lessons from real use

## What the methodology handled well
- **Correction-to-correction pattern.** When a reported test count differed
  from reality, the disagreement itself became the finding. Environmental
  failures masqueraded as claim-inflation in BOTH directions; verifying
  tooling before correcting numbers was the lesson.
- **Enforcement tests caught latent bugs.** A dotenv-loading order bug was
  producing "wrong error code" (401 instead of 403). Weaker smoke tests
  would have shipped it. Contract-shape assertions forced discovery.
- **Reuse maps prevented parallel implementations.** When a scaffold's four
  guardrail checks were derived from spec prose instead of source, two of
  four were wrong. The verify-then-act rule caught it before code was written.

## What the methodology stressed under
- **Trunk-merge-with-pending-gate pattern.** The temptation to merge with an
  integration gate "temporarily pending" recurred multiple times before
  becoming an explicit rule. If your setup has ambiguity about when the gate
  runs, name it as a rule now, not after the third recurrence.
- **Agent tool-call optimism.** Agents sometimes reported "AI agent
  completed" for work the permission layer had actually blocked. Verify
  claims of completion by reading the artifact, not the report.
- **Test-word-grep antipatterns.** A "no bypass" test that grep'd for
  forbidden words in source triggered on documentation legitimately using
  those words. AST-based inspection would have been correct from the start.

## What the methodology has NOT been validated on
- Data migrations at scale (schema evolution, back-compat, rollback drills)
- Multi-agent orchestration where agents talk to each other
- Team collaboration >1 human
- Long-term maintenance (months of use, decision drift)
- Very large codebases (>50k files)
- Regulatory or compliance-heavy environments

Anyone adopting for a case in the second list should proceed carefully and
add their own lessons back to this file.

## Contribution rule
Additions to this file are welcome. Preserve the append-only convention —
add to a "Lessons added by adopters" section at the bottom rather than
editing existing lessons.

## Lessons added by adopters

### 2026-08-13 — branch-level context switching has no methodology support
Applying this ideology to a real org codebase (adopter's own forks,
maintained locally, separate from this repo) surfaced a gap not caught by
the original bootstrap-skill validation: switching between branches mid-work
had **no available context** — nothing surfaced what a given branch was for,
what state it was in, or what the org's own conventions for maintaining
branches were. Compounding it, the same codebase carried **multiple
branches at different, simultaneous states of completion/incompletion**,
and the methodology had no notion of that at all — every artifact assumed a
single current state, not several coexisting ones. Handled for the day with
manual, ad hoc prompting; no repeatable mechanism existed to fall back on.
Tracked as [Phase B1 in the readiness roadmap](../../../docs/adlc-readiness-roadmap.md)
(branch/worktree context delivery), prioritized ahead of the originally
broader worktree-concurrency phase it was carved out of, since this is the
one roadmap item validated by an actual failure rather than an absence
found by grep.
