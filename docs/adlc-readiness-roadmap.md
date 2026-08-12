---
type: Roadmap
title: AgenticLoop → Adoptable AI-SDLC/ADLC Package — Readiness Roadmap
description: Phased plan for packaging AgenticLoop as an npx-installable, vendor/framework-agnostic, worktree-native methodology, plus AgenticRAG corpus-compatibility readiness.
provenance: bootstrap-skill-0.1.0
source-answers: [existing-repo:greenfield, harness:mixed-multi-agent, threat-model:solo-public-repo]
---
# AgenticLoop → Adoptable AI-SDLC/ADLC Package — Readiness Roadmap

**Branch:** `v2` · **Status:** Phase A executed here; Phases B–F and `v3` are
roadmap-only, not yet scheduled.

## How this roadmap came about (iteration history)
1. **Branch restructure** (prior session, done): renamed `main`→`starter` to
   preserve the pre-bootstrap snapshot, kept `v2` as the active bootstrap
   branch, set GitHub's default branch to `v2` for the interim — recorded as
   Decision 11 in `00-environment-decisions.md`.
2. **Owner's next ask:** make the `agentic-loop-bootstrap` skill installable
   anywhere via `npx skills add <source> --skill agentic-loop-bootstrap`
   (the real `vercel-labs/skills` tool), positioned as a vendor-agnostic,
   framework/language-agnostic "AI-SDLC"/ADLC package — worktree-native,
   conflict-safe in large existing codebases, single-command install,
   creating "a stateful setup for all agents."
3. **Research** (this session): confirmed the npx tool's real requirements
   (a file literally named `SKILL.md` + `name`/`description` frontmatter —
   already scoped as a deferred fix from the branch-restructure work);
   confirmed this repo's `AGENTS.md` already matches the shape of the
   now-Linux-Foundation `AGENTS.md` open standard; confirmed git worktrees
   are the established pattern for parallel-agent isolation; confirmed
   "ADLC"/"AI-SDLC" is already used by other vendors for a different purpose
   (AI-agent-product governance, not dev-lifecycle methodology); confirmed —
   via repo-wide search — that this repo has zero existing mechanism for
   worktree isolation, concurrent-agent claims, or zone-scoped adoption in
   large codebases.
4. **Owner's refinement:** pointed at `Agentic_RAG_Insights.md` (repo root —
   a write-up of Stephen Chin/Neo4j's "CrabRAG" talk) and clarified the
   memory-architecture ask precisely: *"real vector DB combined with a graph
   db to convert the existing md files pushed in proper chunks into the
   graph db and can be used for traversal. (not right now, but if I wanted
   to, it should be compatible enough to make such operations.)"* Chunking
   strategy identified as the missing piece; OKF/SKILL format confirmed
   already suitable.
5. **Final scoping (this document):** `v2` gets **only** the AgenticRAG
   compatibility-readiness work (Phase A, below — executed in this session).
   A **future branch `v3`** is where a real vector+graph DB gets stood up
   and tested locally — roadmap-only, not yet scheduled. Everything else
   (worktree primitives, zone-scoped adoption, host-repo generalization,
   cross-session handoff, positioning) is a longer roadmap (Phases B–F)
   gated on the owner's "bootstrap complete" sign-off plus the
   already-deferred npx-filename fix landing on a new `main`.
6. **First real-use hit, outside this repo** (2026-08-13, not gated on
   Gate 0 — happened live): the owner applied AgenticLoop ideology to an
   *org* codebase (their own forks, maintained locally under a separate
   root-level git, not this repo) and hit a gap Phase B as originally
   scoped doesn't cover: switching branch-level context mid-work had
   **no available context**, no way to *dynamically* surface a branch's
   purpose or the org's own branch-maintenance conventions, and no
   handling for **the same codebase carrying multiple branches at
   different, simultaneous states of completion/incompletion**. Handled
   manually (ad hoc prompting) for the day — see the adopter entry in
   `memory/lessons-from-real-use.md`. That gap is now split out as
   **Phase B1** below and moved to the front of the B–F queue: it's the
   only item in this roadmap validated by an actual outside-repo failure
   rather than a repo-wide grep for absence, so it outranks the
   still-hypothetical concurrency-claim mechanism it was originally bundled
   with.

## Context
The overall goal: AgenticLoop installable via one `npx skills add` command,
worktree-native, conflict-safe in large existing codebases, vendor/
framework-agnostic, and compatible with a real hybrid vector+graph memory
backend if/when the owner wants one:

> "Vendor agnostic, Framework/Language agnostic, Stateful experience."

This is grounded in `Agentic_RAG_Insights.md`'s argument (motivating *why*
corpus-compatibility matters, even though the real backend isn't being built
yet):
- **The "bad memory" problem:** agents that stuff every markdown file into
  the context window waste tokens and get amnesia between sessions — fine
  at small scale, broken at enterprise scale.
- **Vector similarity ≠ relationship:** plain embedding search misses real
  multi-hop reasoning chains.
- **The fix is hybrid:** vector search finds seed nodes/chunks, graph
  traversal pulls the real neighbors from there — nodes+edges give exact,
  auditable relationships that plain vector stores can't.
- **Semantic + episodic convergence:** the graph is semantic memory (hard
  facts/relationships); a chronological ledger is episodic memory (what
  happened, when); agents need both, not either alone.

**Already in place, before this roadmap:**
- OKF bundle shape at `skills/agentic-loop-bootstrap/` (phases, questions,
  principles, artifacts, memory, examples) — confirmed by the owner as
  already suitable; every new file below extends this shape, never replaces
  it.
- Root `AGENTS.md` — already matches the shape of the open `AGENTS.md`
  standard ([agents.md](https://agents.md/), Linux-Foundation-donated Dec
  2025, 60k+ repos, 20+ tools) — a real asset for the vendor-agnostic claim.
- Six-step loop, three-actor pattern, append-only decisions log,
  state-in-repo principle, provenance labels.
- `graphify` — already builds `graphify-out/graph.json` from this repo's own
  markdown corpus, extracting nodes from files and edges from markdown
  links/structure. Today's link-based graph, positioned as a
  "graph-before-grep" navigation shortcut — not a vector-seeded hybrid
  system, and not upgraded to one by this roadmap.
- State files already carry a `branch:` field and full `agent_log:` history
  — the episodic-memory half of the CrabRAG picture, already written, just
  not named as this before now.
- npx-compatibility fix (rename `skill.md`→`SKILL.md`, add `name:`
  frontmatter, fix cross-reference links) — already scoped, **deferred** to
  a new `main` cut from `v2`, only after the owner says "bootstrap
  complete." Do not assume that's happened.

**The other confirmed gap:** `README.md`'s Maturity section and
`skills/agentic-loop-bootstrap/memory/lessons-from-real-use.md` both
explicitly list "multi-agent orchestration," "team collaboration," and
"very large codebases" as **not validated.** A repo-wide search confirms
zero hits for "worktree," "concurrent," "parallel agent," or "lock" anywhere
in the methodology.

**External grounding:**
- [AGENTS.md](https://agents.md/) — the open standard this repo resembles.
- Git worktrees as the established pattern for parallel-agent isolation
  ([MindStudio](https://www.mindstudio.ai/blog/parallel-ai-coding-agents-git-worktrees),
  [Augment Code](https://www.augmentcode.com/guides/git-worktrees-parallel-ai-agent-execution)).
- Spec-driven development breaks down in large monorepos unless specs stay
  scoped near the area of change
  ([Augment Code](https://www.augmentcode.com/guides/automating-spec-driven-development-with-ai-agents)).
- "ADLC"/"AI-SDLC" already used by Arthur.ai, Glean, Salesforce, IBM, EPAM
  ([sumatosoft](https://sumatosoft.com/blog/what-is-adlc-agentic-development),
  [IBM](https://www.ibm.com/think/topics/agent-development-lifecycle-adlc))
  for governing AI-agent *products* — different emphasis than "using coding
  agents to run a dev lifecycle." Naming-collision risk, not a blocker —
  recommendation in Phase F.

---

## Phase A — AgenticRAG Compatibility Readiness (scoped to `v2`) — **DONE**
**Closed:** owner's compatibility-readiness ask, without building the real
backend yet.

Delivered:
- [`docs/agentic-rag-compatibility.md`](agentic-rag-compatibility.md) —
  chunking strategy (per file type: decisions log, OKF single-concept
  files, state files split stable/log, task specs), a deterministic
  `<file-path>#<heading-anchor>` chunk-ID scheme, a node/edge schema mapping
  reusing existing OKF frontmatter and markdown links (no new metadata
  invented), and a reserved-but-empty `embedding:` field placeholder.
- Confirmed OKF bundle shape and `SKILL.md`/frontmatter format need zero
  changes — owner confirmed both already suitable.
- Pointer updates: `specs/tasks/00-spec-system.md` §9 and `AGENTS.md`'s
  graph-before-grep rule now reference the compatibility doc;
  `00-environment-decisions.md` Decision 12 records this phase.

**Explicit non-goals (still true):** no vector DB or graph DB installed, no
embeddings generated, no schema migration run, `graphify`'s runtime
behavior unchanged.

---

## Future — `v3` (new branch): Real AgenticRAG Local Test Setup
**Not yet scheduled — owner decides timing**, separate from the Gate-0-gated
phases below.
- Cut a new branch `v3` (from `v2`, timing TBD — don't assume it waits for
  "bootstrap complete").
- Stand up a local hybrid vector DB + graph DB. Candidates to evaluate, none
  chosen yet: Neo4j (the CrabRAG/Cognee reference stack named in
  `Agentic_RAG_Insights.md`), or a lighter fully-local alternative.
- Implement the chunking pipeline exactly as specified in
  `docs/agentic-rag-compatibility.md`.
- Ingest the full existing markdown corpus.
- Test real hybrid retrieval end-to-end (vector-seed → graph-traverse) and
  compare recall/precision against today's graphify link-based traversal.
- Exploratory/local-only — nothing here replaces graphify in the shipped
  methodology until proven out.

---

## Gate 0 — Preconditions for Phases B–F
1. Owner explicitly says "bootstrap complete" for the current v2 bootstrap
   (task #8, still open — no other phrasing satisfies it).
2. The already-approved npx-filename fix lands on a new `main` cut from
   `v2` (rename `skill.md`→`SKILL.md`, add `name:`/`description:`
   frontmatter, fix ~7 cross-reference links, update README quick-start).

## Phase B — Worktree- and Branch-Native Primitives
Split into two sub-phases, **B1 ahead of B2** in priority — B1 is the one
item in this roadmap backed by an actual outside-repo failure (2026-08-13,
see item 6 above and the adopter entry in `memory/lessons-from-real-use.md`)
rather than a repo-wide grep for absence. Both remain gated behind Gate 0
like the rest of Phases B–F; the reordering only affects which lands first
once the gate opens.

### Phase B1 — Branch/Worktree Context Delivery **(elevated priority)**
**Closes:** no available context on branch-level context switch; no
mechanism to *dynamically* surface a branch's purpose, completion state,
or the host org's own branch-maintenance conventions; no handling for one
codebase carrying several branches at different, simultaneous states of
completion at once.
- `artifacts/branch-briefing.md` — a per-branch/worktree context capsule:
  what this branch is for, its current completion state (pointers into
  `specs/tasks/*.state.md`, not a restated summary), and the org's branch
  conventions (naming scheme, protected branches, merge target, review
  requirements, stale-branch policy). Written once per branch, updated at
  loop-step boundaries alongside the state file it points to.
- `questions/org-branch-conventions.md` — a grill question, asked once per
  *host* repo (not per branch), capturing the org's own branching policy so
  it doesn't have to be re-derived or re-asked on every switch.
- `phases/00-context-scan.md` extension — on branch/worktree switch,
  surface the matching `branch-briefing.md` before any other action, the
  same way context-scan already runs before Phase 1 today.
- `TEMPLATE-state.md`'s existing `branch:` field gets a documented
  resolution rule: it MUST resolve to a `branch-briefing.md`, not just name
  the git branch string.
- `memory/failure-modes.md` — new entry: branch switched with no briefing
  present (the exact failure hit on 2026-08-13, handled by ad hoc manual
  prompting instead of methodology support).

### Phase B2 — Worktree-Native Concurrency Primitives
**Closes:** the confirmed-absent mechanism for concurrent agents/worktrees.
(Repo-wide-grep-confirmed absence, not yet hit in real use — see the
priority note above.)
- `principles/worktree-isolation.md` — one branch + one worktree per
  task/agent, sharing the single `.git` object store; agents are *assigned*
  a worktree, never permanently own one.
- `questions/concurrency-model.md` — solo vs. multi-agent-worktree grill
  question.
- `TEMPLATE-state.md` gains `worktree:` and `claimed_by:`/`claim_expires:`
  fields, extending the existing `branch:` field.
- `artifacts/task-claim.md` — a `*.claim.md` sidecar (agent id, worktree
  path, session id, heartbeat), written before step 1 of the six-step loop,
  deleted on "record"; chunked/graphed per Phase A's scheme so a second
  agent's query surfaces the live claim.
- `memory/failure-modes.md` — new entries: stale claim, racing worktrees.

## Phase C — Zone-Scoped Adoption for Large/Existing Codebases
**Closes:** "avoid conflicts in larger codebases," generalizing the
contract-boundary rule from sibling-repos to zones inside one repo.
- `questions/zone-scope.md`, `phases/00-context-scan.md` extension,
  `artifacts/zone-agents-md.md`, `principles/zone-boundary.md`.
- Reuses graphify's graph-before-grep rule as the primary conflict-avoidance
  mechanism.

## Phase D — Generalize the Bootstrap for Foreign Host Repos
**Closes:** vendor/framework-agnostic single-command install actually
*doing* something in someone else's repo.
- `phases/02-tailor.md` extension to emit host-tailored artifacts into the
  host's own `specs/tasks/`; `artifacts/host-agents-md.md`;
  `questions/existing-repo.md` extension; document the graphify hook drop.

## Phase E — Stateful Cross-Session / Cross-Worktree Handoff
**Closes:** "easily transitionable across worktrees & states for a
developer" — graph (semantic) + `agent_log:` (episodic) convergence.
- `artifacts/session-handoff.md` (reuses `/handoff` skill's output shape);
  formalize `agent_log:` as the canonical episodic-resumption source.

## Phase F — Positioning Pass
- Update README Maturity section only after B–E are actually exercised.
- Tagline: "Vendor agnostic, Framework/Language agnostic, Stateful
  experience."
- **Naming callout:** keep **AgenticLoop** as the proper-noun brand; use "an
  ADLC-style methodology" only as a descriptive category, never the primary
  name — avoids implying parity with the enterprise AI-agent-governance
  products already using "ADLC."

---

## Verification
- **Phase A:** `docs/agentic-rag-compatibility.md` exists and covers all
  file-type chunking rules; `graphify-out/graph.json` unchanged
  before/after.
- **v3:** a fresh session, given only the real vector+graph DB, correctly
  answers a multi-hop question, compared against graphify's current answer.
- **Phase B1:** switch branch/worktree on a repo with two branches at
  different completion states; the correct `branch-briefing.md` (not the
  other branch's) surfaces before any other action, including the org's
  branch conventions.
- **Phase B2:** two worktrees attempt the same task; second detects the live
  claim.
- **Phase C:** context-scan against a synthetic multi-manifest monorepo
  fixture correctly flags zone candidates.
- **Phase D:** dry run of `npx skills add <local-path> --skill
  agentic-loop-bootstrap` against a throwaway scratch repo, then the real
  install from a fresh scratch directory.
- **Phase E:** simulate a handoff (kill one agent mid-task, resume in a new
  worktree from graph + `agent_log:` alone).
- **Phase F:** review only.

## Explicitly not covered
- Any file writes for Phases B–F, `v3`, or the npx-filename fix — deferred
  per Gate 0 / owner scheduling.
- Choosing a specific vector DB / graph DB product — `v3` evaluates
  candidates without pre-selecting one.
- A firm timeline/owner for each phase beyond Phase A.
