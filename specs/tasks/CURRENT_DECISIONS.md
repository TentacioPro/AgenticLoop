---
type: DecisionsCurrentView
title: Current decisions (live view)
description: Short list of decisions still in force. Full rationale, rejected alternatives and timestamps are in the append-only ledger; read that only when this view isn't enough.
provenance: bootstrap-skill-0.1.0
---
# CURRENT_DECISIONS.md — read this, not the full ledger, by default

Full ledger (append-only, rejected alternatives, exact rationale, ISO timestamps): `00-environment-decisions.md`.
Read the ledger only when you need a decision's reasoning or history — not as part of every session's mandatory read path.

- **Branch:** work happens on `v2` (cut from `main`/`starter`), or a branch cut from `v2`. — Decision 1
- **Graphify:** one shared `uv venv` outside any repo, post-commit hook rebuilds automatically on code commits, doc-only changes need a manual `/graphify --update`, extraction cache deleted after every build. — Decision 2
- **This repo's own classification:** greenfield bootstrap target; stack = Other (markdown/OKF/skill bundle, no application code or test runner of its own). — Decisions 3–4
- **Harness:** mixed/multi-agent. `AGENTS.md` is the single vendor-neutral source of truth; per-harness pointer files (`CLAUDE.md` etc.) never duplicate its content. — Decision 5
- **Threat model:** solo public repo — treat secrets/CI exposure and anything an anonymous visitor could trigger with real care, even with no outside contributors yet. — Decision 6
- **Verify cadence:** phase boundary — report status at the end of each phase, don't cross one silently. — Decision 7
- **Bootstrap status:** mechanically complete on `v2`, gated for owner review. Do not declare "bootstrap complete" — only the owner says that phrase. — Decision 9
- **Smoke test:** kept in the repo (`01-bootstrap-smoke-test*`) as the first worked example of the loop, not deleted after verification. — Decision 10
- **Branch naming:** `main` renamed to `starter` locally (preserves the pre-bootstrap snapshot); the GitHub-side rename and default-branch change are the owner's own manual step, not yet done — don't assume it's landed. — Decision 11
- **AgenticRAG:** `v2` ships compatibility-readiness only (chunking scheme + schema mapping in `docs/agentic-rag-compatibility.md`); no vector/graph DB is installed. Real implementation is deferred to a future branch `v3`, not yet scheduled. — Decision 12

Superseded or one-off decisions (npx-packaging deferral, optional-question skips) are in the ledger only; they don't constrain today's work and aren't repeated here.
