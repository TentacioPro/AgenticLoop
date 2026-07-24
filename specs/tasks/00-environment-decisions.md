---
type: DecisionsLog
title: Environment & Methodology Decisions
description: Append-only log of every environment/methodology decision made during and after bootstrap.
provenance: bootstrap-skill-0.1.0
source-answers: []
---
# 00-environment-decisions.md

Append-only. Corrections are new numbered entries that reference the old
number — never edit a prior entry in place.

## Decision 1: Branch Strategy
Chosen: All AgenticLoop v2 bootstrap work happens on branch `v2` (cut from `main`), and all future setup-agent sessions for this bootstrap continue on `v2` or branches cut from it.
Rejected:
- Work directly on `main` — no isolation between in-progress bootstrap state and the stable default branch.
- One feature branch per phase (context-scan/grill/tailor/verify each on its own branch) — unnecessary overhead for a single coherent bootstrap effort; `v2` already isolates it from `main`.
Rationale: Explicit owner instruction — "git checkout -b v2 (from the default branch). All work in this session and all future agent sessions for this setup happen on v2 or branches cut from it."
Recorded: 2026-07-24T00:00:00Z

## Decision 2: Graph Tool, Shared Install, Rebuild Cadence, Cache Policy
Chosen:
- **Tool:** graphify (`graphifyy` 0.9.25 on PyPI) builds and queries the knowledge graph for this repo.
- **Install location:** one shared `uv venv` at a top-root directory outside any repo (`E:\.venv-graphify`), with `graphifyy` installed via `uv pip install` into it. This single install is reused by this repo and any sibling repos — never a per-repo install.
- **Output path:** `graphify-out/graph.json` + `graphify-out/GRAPH_REPORT.md` are the only tracked files; `graphify-out/*` is gitignored otherwise (viz HTML, cost.json, manifest.json, interpreter-pointer files).
- **Rebuild cadence:** post-commit git hook (`graphify hook install`), pinned to the shared venv's python at install time. Code-change commits trigger an automatic detached rebuild (AST only, no LLM/cost); doc/image changes are not auto-rebuilt by the hook and require a manual `/graphify --update`. A `post-checkout` hook and a `graph.json` git merge driver were also installed as part of the same command.
- **Cache policy:** graphify's extraction cache (`graphify-out/cache/`) is deleted immediately after each build. Consequence (accepted): the next `--update` run cannot replay cached extractions and will re-run semantic extraction (token cost) even for unchanged files.

Rejected:
- Per-repo graphify install (`uv venv` inside each repo, or `pip install` directly into the repo's own environment) — duplicates the install across every repo the methodology is applied to; a shared top-root install serves any number of repos from one place.
- `.graphify/graph.json` path (as originally specified) — the installed graphify package writes to `graphify-out/`, not `.graphify/`; adapted to reality rather than forcing a nonstandard path.
- `graphify install --project` (as originally specified) — the installed CLI has no `--project` flag; used `graphify install` (skill sync) + `uv pip install -U graphifyy` (package) instead.
- Rebuild on-gate (as part of the six-step loop's gate step) — rejected in favor of the post-commit hook so graph freshness isn't coupled to task-gate timing.
- Manual-only rebuild (`/graphify --update` by hand) — rejected as the sole mechanism; lowest automation, highest staleness risk. (Still available/required for doc-only changes, since the hook doesn't cover those.)
- Keep the extraction cache — rejected per explicit owner instruction that "the graphify-out directory contains Cache which needs deletion after the graph is created," even though this raises future `--update` token cost.

Rationale: Owner instructions across two turns — "For installing python packages, utilize UV VENV to do those... If the user prefers to install graphify on a top-root directory to keep the graph alone in the repo, utilize the same installation for any number of repos, that should be accepted... the graphify-out directory contains Cache which needs deletion after the graph is created."

Deviation note: the deletion of `graphify-out/cache/` required a scoped one-off exception to the `rm -rf` deny rule added in the permissions front-load step; done via a Python `shutil.rmtree` call instead of shell `rm -rf`, per owner's explicit choice ("scoped delete this once") when asked.

Recorded: 2026-07-24T00:00:00Z
