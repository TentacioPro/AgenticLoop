---
type: Todo
title: AgenticLoop TODO
description: Live task list for validating and slimming the harness. Last updated 2026-09-24.
---
# TODO (last updated 2026-09-24)

Legend: `[ ]` open, `[x]` done, `[~]` blocked on owner input. Context: [`CONTEXT.md`](CONTEXT.md).

## Thinness (fix first; cheap, measurable)
- [x] Added `CURRENT_DECISIONS.md` (live decisions plus a link to the ledger) and pointed the router at it (`AGENTS.md` #2,
      `00-spec-system.md` §5). Re-measured: mandatory read path 29 KB → 15 KB (~7.3k → ~3.8k tokens). T4 (append-only log
      never in the read path) now passes. T2 (<= 10 KB) still not met — the remaining weight is `00-spec-system.md` itself
      (6.2 KB, 110 lines), which is real non-negotiable-process content; trimming it is a separate, more careful edit, not
      done here. See `specs/tasks/00-spec-system.md` §5 for the maintenance rule: whoever appends a ledger decision also
      updates (or explicitly skips updating) `CURRENT_DECISIONS.md` in the same commit, so the two files can't silently drift.
- [ ] Decide the rule for the workspace-root install (674-line log): archive superseded decisions, keep the current view short.
- [ ] Define risk tiers (`micro`, `standard`, `high-risk`) so a typo fix does not need the full loop.
- [ ] Give each always-read file a size cap and a last-verified date.

## Consistency across installs
- [ ] Choose one state vocabulary (`not_started`, `in_progress`, `blocked`, `review`, `done`, `superseded`) and record why.
- [ ] Write a small validator: frontmatter present, status in the list, links resolve, `last_verified` non-empty when `done`.
- [ ] Decide an upgrade path so a change to the template can reach installs without silent overwrites.
- [ ] Add a `.gitignore` check to the skill for credential-named files, and a warning about copying them into backups.

## Evidence (needs no new agent runs)
- [ ] Score the pre-rollout baseline from existing transcripts for Quick_yt, AirLLM, the workspace root and 2026/ABC.
- [ ] Read the state files for pasted gate output; count `done` tasks with and without it.
- [ ] Note which agent tool touched each install (transcripts, not folder names).
- [ ] Create `evals/runs.csv` with the columns from the validation plan.

## Professional scaffolds (weekend of 2026-09-26/27)
- [~] Owner provides the scaffolds. Before rollout: record commit SHA, thinness output and last ~5 scored sessions per project.
- [ ] Anonymise everything that goes in this public repo; keep the raw analysis in the private research notes instead.

## Later, only if the pilot shows a signal
- [ ] Pilot: 4 golden tasks x 2 arms (four-file method vs AgenticLoop) x 2 runs. Ask before launching (usage cost).
- [ ] Roadmap phases B-F from `docs/adlc-readiness-roadmap.md` (branch and worktree context first).

## Done
- [x] 2026-09-24: validation plan and `scripts/thinness.sh`; first survey of installs (see CONTEXT).
