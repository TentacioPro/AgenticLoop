---
provenance: bootstrap-skill-0.1.0
source-answers: [existing-repo:greenfield, stack:other, harness:mixed-multi-agent, threat-model:solo-public-repo, verify-cadence:phase-boundary]
---
# AGENTS.md — vendor-neutral entry point

You are working in AgenticLoop. Before any tool call:

1. Read `specs/tasks/00-spec-system.md` — the process, non-negotiable.
2. Read `specs/tasks/00-environment-decisions.md` — the settled choices.
3. Find your task's state file: `specs/tasks/<NN>-<name>.state.md`.
4. Follow the six-step loop: read → red → green → gate → record → update.
5. Work ONLY inside your task's FILE SCOPE.
6. Never claim something works without pasted test output.
7. Never overwrite decisions. Corrections happen as new numbered entries.

Stack: Other — markdown / OKF / skill-definition bundle. This repo IS the
`agentic-loop-bootstrap` skill's own source; it has no application code or
test runner of its own.
Harness expectation: Mixed / multi-agent — Claude Code, Kimi, OpenClaw, or
others may work this repo across contributors/sessions. This file is the
vendor-neutral source of truth; per-harness pointer files (e.g. CLAUDE.md)
point here and never duplicate its content.
Threat model: Solo public repo — one person commits/decides, but the repo is
public. Treat secrets/CI exposure and anything an anonymous visitor could
trigger with the same care as a public-facing project, even though no
outside contributions are accepted yet.

## Graph-before-grep rule
Before running a broad grep/search to orient yourself in this repo, check
`graphify-out/graph.json` first (e.g. `/graphify query "<question>"`,
`/graphify explain <node>`, `/graphify path <a> <b>`). The graph is kept
fresh by a post-commit hook (see Decision 2 in
`specs/tasks/00-environment-decisions.md`) and answers "what governs X" /
"what depends on Y" faster and more reliably than an unstructured grep sweep.
Fall back to grep only for things the graph doesn't model (exact string
matches, one-off greenfield files not yet committed).

## Contract-boundary rule
This is **repo A of 2**. Its sibling repo is `<SIBLING_REPO>` (TODO — fill in
when the sibling is identified). Stay inside this repo's contract boundary:
do not reach into, assume the internal structure of, or make edits to the
sibling repo from a session rooted here. Any change that needs to cross the
boundary (shared schema, shared API contract, cross-repo rename) must be
surfaced to the owner as an explicit escalation, not performed silently from
one side.

Escalate to owner if any rule in `specs/tasks/00-spec-system.md` §escalation
would be violated by proceeding.
