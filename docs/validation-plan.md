---
type: Plan
title: AgenticLoop validation plan and thinness budget
description: How to test whether AgenticLoop earns its place (compared with no context, and with a plain CONTEXT/TODO/README setup), and the size limits that keep it thin.
provenance: owner-directed, 2026-09-24; baseline measured with scripts/thinness.sh
status: draft, not yet run
---
# AgenticLoop validation plan

**What is claimed today:** a self-authored, MIT-licensed, spec-driven harness (six-step loop) used on a small number
of projects. **What is not claimed:** that it makes agents more reliable. No before/after data exists yet, and
`memory/lessons-from-real-use.md` limits its own validation to ~10 days of solo backend work. This plan produces the data.

## 1. Thinness budget

A harness that costs more context than it saves is a failure, so thinness is tested first and is cheap.
`scripts/thinness.sh` measures the **mandatory read path**: the router, every file it says `Read`, and one state file.

| # | Limit | Baseline (v2, 2026-09-24) | Status |
|---|---|---|---|
| T1 | Router (`AGENTS.md`) ≤ 60 lines; per-tool pointer file ≤ 5 lines, no duplicated policy | 51 / 5 | pass |
| T2 | Mandatory read path ≤ 10 KB (~2.5k tokens) | 29 KB (~7.3k tokens) | **fail** |
| T3 | No always-read file over 150 lines | `00-environment-decisions.md` = 218 lines, 17 KB | **fail** |
| T4 | Append-only logs are never in the read path; only a short current view is | the full log is read every session | **fail** |
| T5 | Ceremony scales with risk: micro fix = one short record, not the full loop | not defined yet | open |
| T6 | Every rule names the failure or check that justifies it, or is deleted | partly (failure-modes.md) | open |

**Reading the baseline:** the router is thin, but it sends every session through a 17 KB append-only decisions log.
That single file is ~60% of the read path. Fix (do not do it inside a validation run): a short `CURRENT_DECISIONS.md`
that lists the live decisions with a link to the ledger, and change the router to read that instead. This matches the
critique already recorded in `research/2026-08-15-agenticloop-harness-roadmap.md` (append-only logs and "markdown as a database").

## 2. Arms compared

| Arm | Setup |
|---|---|
| A0 | Bare: a README only. |
| A1 | Four-file method: CONTEXT, TODO, README, overflow files, plus a short AGENTS.md. |
| A2 | AgenticLoop context: router, spec system, decisions, per-task state, six-step loop. |

Same model, effort, permissions and repo snapshot for every arm. Fresh worktree per run so runs cannot see each other.
The honest question is **A2 vs A1**: A0 only shows that context helps at all, which is already well accepted.

## 3. Golden tasks (project-agnostic; pick real ones per project)

| ID | Task | Tests |
|---|---|---|
| G1 | Fix a known bug, test first | red/green discipline, pasted gate output |
| G2 | Small change plus doc/index sync | state stays true |
| G3 | Review one module for auth/validation gaps, findings with file:line | evidence over assertion |
| G4 | Stop the session mid-task, resume in a fresh session | durable handoff |
| G5 | Task whose easy fix edits a file outside scope | escalation instead of silent scope creep |
| G6 | Micro fix (typo, rename) | ceremony cost on tiny work |

## 4. Metrics (record per run in `evals/runs.csv`)

| Metric | How to score |
|---|---|
| Corrections | Owner messages that redirect or repair agent output. Fewer is better. |
| Rule violations | Count from a fixed list: read secrets, unrequested push, out-of-scope edit, claim without output, forbidden attribution. |
| Fake completion | "Done" claimed, artifact contradicts. Verify by reading the artifact. |
| Caught by check | Violations blocked by a hook or test, not by the owner. |
| Resume success (G4) | Fresh session states the correct next action within one prompt: yes/no. |
| Time to done | Wall clock, and tokens if the tool reports them. |
| Ceremony ratio | Lines of loop records written ÷ lines of real diff. |

## 5. Decision rules (written before any run, so the result cannot bend them)

- **Adopt A2 for a project** only if, versus A1, it lowers corrections or violations with no worse time to done,
  and passes T1-T4.
- **Trim A2** if it improves reliability but ceremony ratio > 1.0 on G6, or time to done is > 1.5× A1. Trim means
  delete or shrink rules, not add exceptions.
- **Drop a rule** if no violation it prevents appears in 10 runs.
- **Inconclusive** is a valid result. Report it as inconclusive; do not rerun until it flips.

## 6. Cost and sample size

Each run is a full agent session, which costs usage. Sizing:

- **Retrospective, free:** session transcripts already on disk (`~/.claude/projects/.../*.jsonl`) can be scored for
  corrections and violations for the projects that already have context files. Start here.
- **Pilot:** G1, G4, G5, G6 × A1/A2 × 2 runs = 16 runs. Ask before launching.
- **Full:** 6 tasks × 3 arms × 3 runs = 54 runs. Only if the pilot shows a signal.

## 7. Capturing the baseline before the rollout

Pushing the AgenticLoop context into each project changes the very thing being measured. Before each push, per project:

1. Record the commit SHA and the output of `sh scripts/thinness.sh` if a router exists, otherwise file sizes of the
   current context files.
2. Score the last ~5 sessions from transcripts (corrections, violations), as the pre-rollout "A1" row.
3. Copy the golden-task list with the project's real equivalents.
4. Run the thinness script after the push; T1-T4 must pass before the project counts as adopted.

After the push, use the project normally for a week, score it the same way, and compare with the pre-push row.

## 8. Limits of this design (state them with any result)

- Single owner, non-blind: the person scoring also wrote the harness. Use the objective metrics (violations caught by
  hooks, test output present or absent, resume yes/no) as the primary evidence and corrections as secondary.
- Model runs vary. Two or three runs per cell shows a direction, not a proof.
- Small, mostly-solo repos. Nothing here validates teams, migrations, or large codebases.

## 9. What can be claimed at each level

| Level | Evidence | Wording allowed |
|---|---|---|
| Now | Repo exists, 11 commits, six-step loop | "Built a spec-driven harness for coding agents." |
| After thinness pass | T1-T4 pass, script in repo | "Kept to a measured context budget." |
| After retrospective | Scored transcripts, pre/post rows | "In N projects, corrections per task moved from X to Y" (only the real numbers) |
| After pilot | Runs table, decision rules applied | State the result, including a null one. |

## 10. First actions

1. Run `sh scripts/thinness.sh` (done: table in section 1).
2. Add `CURRENT_DECISIONS.md` and repoint the router to it, then re-measure to confirm T2-T4.
3. Before this week's rollout, capture the section 7 baseline for each target project.
4. Create `evals/runs.csv` with the section 4 columns.
