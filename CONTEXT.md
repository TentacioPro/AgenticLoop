---
type: Context
title: AgenticLoop current state
description: Short current-state file. Where the harness is installed, what the first survey found, and what is being validated. Last verified 2026-09-24.
---
# CONTEXT: current state (last verified 2026-09-24)

Purpose of this file: one page a new session can read to know where things stand. Details live in
[`docs/validation-plan.md`](docs/validation-plan.md) (how to test the harness) and
[`docs/adlc-readiness-roadmap.md`](docs/adlc-readiness-roadmap.md) (packaging plan). Open work is in [`TODO.md`](TODO.md).
Keep this file under ~100 lines; move history to a dated archive file.

## What this is
A spec-driven method for coding agents: six-step loop (read, red, green, gate, record, update), state kept in the repo as
markdown, decisions append-only. It is a guide and an evidence contract, not an autonomous backbone.
Status: honest v0.1. It has no measured before/after yet; the validation plan exists to produce one.

## Where it is installed (survey of the D: drive, 2026-09-24)
Read-only survey using `scripts/thinness.sh` plus the specs folders. Harness folders found: `.claude` everywhere and `.agy`
(Antigravity) in Quick_yt. No `.pi`, `.opencode` or `.codex` folders exist, but those tools read `AGENTS.md` without one,
so that is not evidence they were not used; check transcripts before saying which tools touched what.

| Install | Marker date | Tasks / state files | Commits | Read path | Notes |
|---|---|---|---|---|---|
| Quick_yt (monorepo) | none (predates marker) | 38 / 37, nearly all `closed` | 27 | ~3.7k tokens | Heaviest use. Own spec-system grew to 161 lines. No `CLAUDE.md`. Formalised against v2 on 2026-08-05. |
| AirLLM (local-LLM lab) | 2026-08-06 | 14 / 8: 4 done, 2 in progress, 1 blocked, 1 not started | 13 | ~6.9k tokens | Decisions log 153 lines, over budget. |
| D:\ workspace root | none | 7 / 5: 2 done, 1 in progress, 2 blocked | not a git repo | ~12.2k tokens | Worst read path: decisions log 674 lines (42 KB). No version control on the state. |
| 2026/ABC (UI project) | 2026-09-14 | 4 / 3: 2 done, 1 review | 0 (no commits yet) | ~3.6k tokens | Cleanest and newest. Nested `AgenticLoop` copy inside. |
| quickyt_backup | none | copy of Quick_yt | not a git repo | ~1.7k tokens | A backup, not a separate use. Exclude from analysis. |
| cognitive-os / AgenticLoop | 2026-07-27 | 3 / 1 | 12 | ~7.3k tokens | This repo. Fails T2-T4 of the thinness budget. |

## Findings from the survey (observations, not conclusions)
1. **Read path grows with the decisions log.** The router file stays small (16-51 lines) in every install, but the always-read
   append-only decisions log reaches 17 KB here and 42 KB at the workspace root. That is the main thinness problem.
2. **Copies drift.** The spec-system file is 66 to 161 lines across installs (template: 99). There is no upgrade path, so each
   install evolves alone.
3. **State vocabulary drifts.** Template says `done`; installs also use `closed`, `superseded`, `review`, `blocked`. Nothing
   validates state files, so tooling cannot rely on them.
4. **Real use is uneven.** One install carries almost all the usage (Quick_yt). The other three are small; one has no commits.
   Any claim from this evidence is about a handful of solo hobby-scale projects.
5. **Credential file present but ignored.** Quick_yt has a credential-named file that is git-ignored and untracked. Not opened.
   Still worth keeping out of any backup that is copied or uploaded (the backup folder holds a copy).
6. **Not yet checked:** whether `last_verified` blocks contain pasted output, whether the loop was actually followed per commit,
   and which agent tool did which task. Those need the state files and transcripts, not a directory listing.

## Next input expected
The owner will provide professional-repo scaffolds (weekend of 2026-09-26/27) to analyse alongside these. Before adding them,
capture the pre-rollout baseline in section 7 of the validation plan.

## Rules for this repo
- Personal repo, public. No client, employer or third-party names, no candidate data, no credentials, in any file.
- Decisions and lessons files are append-only. Corrections are new entries.
- Commit as `TentacioPro`. Push only with the owner's go-ahead in that session.
