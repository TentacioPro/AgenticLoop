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

## Decision 3: Existing Repo State
Chosen: Greenfield — this repo (AgenticLoop, the skill's own home) had no root `AGENTS.md`, no `CLAUDE.md`, and no `specs/` directory before this bootstrap session began. No prior AgenticLoop scaffolding had been applied to it as a project.
Rejected:
- Brownfield-empty-specs — a `specs/` directory now exists, but only because this session created it; there was no pre-existing empty ledger to build on.
- Brownfield-partial-methodology — rejected as a category error: this repo containing the methodology's own source/definition (it IS the agentic-loop-bootstrap skill) is not the same as this repo having been bootstrapped. Scaffolding presence, not content presence, is what this question tracks.
- Brownfield-competing-methodology — no competing methodology is in place here.
Rationale: Owner confirmed after clarifying discussion — the question characterizes whether *this repo as a target project* had bootstrap scaffolding applied to it already, independent of the fact that its content happens to define the methodology. Owner also directed: for any other repo this skill bootstraps, the existing-repo question (and the rest of the grill) must still be asked normally, one question per turn, to whoever is running it — this meta-repo's special interpretation does not change that mechanism.
Recorded: 2026-07-24T00:00:00Z

## Decision 4: Primary Stack
Chosen: Other — this repo is a markdown/OKF/skill-definition bundle (the agentic-loop-bootstrap skill's own source). No application code, no test runner exists in this repo itself.
Rejected:
- Python — no Python source lives in this repo (the shared graphify venv is tooling outside the repo, not this repo's stack).
- TypeScript/Node — no JS/TS source lives in this repo.
- Mixed — owner's first answer, but on clarification this named *future target projects the skill will be run against* (see note below), not multiple languages actually present in this repo today. "Mixed" would misrepresent this repo's own (empty) stack.
Rationale: Owner clarified that this repo has no code — it's markdown/OKF/skill files only — so the honest answer for what shapes *this repo's* settings.json/AGENTS.md is "Other."
Note (informational, not part of this decision): owner's intended target stacks for future bootstrap runs of this skill are React JS/JSX, Node.js, UV Python, Next.js, and React Expo. This does not change this repo's own stack answer; it's context for how the skill should behave when applied elsewhere.
Recorded: 2026-07-24T00:00:00Z

## Decision 5: Coding Agent Harness
Chosen: Mixed / multi-agent — more than one coding-agent harness works in this repo across contributors/sessions. AGENTS.md remains the single vendor-neutral source of truth; per-harness pointer files (e.g. CLAUDE.md) are added only as thin pointers, never duplicated content.
Rejected:
- claude-code (only) — would understate the actual harness mix; this session alone is Claude Code, but that's not the only harness expected to touch this repo.
- kimi / openclaw (only) — same issue in the other direction; a single non-Claude-Code harness doesn't match either.
- unknown — rejected because the owner gave a definite answer; no need to defer.
Rationale: Owner's direct selection — mixed-multi-agent.
Recorded: 2026-07-27T00:00:00Z

## Decision 6: Threat Model
Chosen: Solo public repo — one person commits/decides, but the repo itself is public, so secrets/CI exposure and anything an anonymous visitor could trigger must be treated more carefully than a purely local repo, even though no outside contributions are accepted (yet).
Rejected:
- solo-local — would understate exposure; this repo is public, not local-only.
- small-team — overstates the actual contributor set; still just the owner deciding/committing.
- public-with-contributors — overstates current state; no outside PRs are being accepted yet, so the tightest untrusted-contributor profile isn't warranted yet.
Rationale: Owner's direct selection — solo-public-repo.
Recorded: 2026-07-27T00:00:00Z

## Decision 7: Verification Cadence
Chosen: Phase boundary — the owner inspects/verifies at each phase boundary (e.g. end of context-scan, end of grill, end of tailor, end of verify) rather than at every single merge or only rarely.
Rejected:
- every-merge — higher scrutiny than requested; would slow throughput beyond what the owner wants.
- weekly — too coarse a cadence for a bootstrap session with several distinct phases inside a single sitting.
- rare — too little scrutiny; owner has been actively steering each phase (grill, permissions, graph tooling) rather than trusting the loop to self-certify.
Rationale: Owner's direct selection — phase-boundary.
Recorded: 2026-07-27T00:00:00Z

## Decision 8: Optional Grill Questions (CI system, testing baseline, deploy target)
Chosen: Skip all three optional questions and proceed straight to Phase 2 (Tailor). Marked not-applicable rather than answered.
Rejected:
- Answering CI system — no CI is configured or needed; this repo has no code to build/run.
- Answering existing testing baseline — no test runner exists in this repo (per Decision 4, stack = Other); there is nothing to baseline.
- Answering deploy target — this repo is not deployed; it's a methodology/skill source bundle, not an application.
Rationale: Owner's direct selection — skip, given the repo's stack is "Other" (markdown/skill-definition only, no application code).
Recorded: 2026-07-27T00:00:00Z
