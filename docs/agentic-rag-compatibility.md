---
type: CompatibilitySpec
title: AgenticRAG Compatibility — Chunking & Schema Mapping
description: How this repo's markdown corpus should be chunked and mapped to nodes/edges so a future real vector+graph DB can ingest it without redesigning the corpus.
provenance: bootstrap-skill-0.1.0
source-answers: [agentic-rag:compatibility-readiness-only]
---
# AgenticRAG Compatibility — Chunking & Schema Mapping

## Why this exists
The owner's goal, verbatim: *"real vector DB combined with a graph db to
convert the existing md files pushed in proper chunks into the graph db and
can be used for traversal. (not right now, but if I wanted to, it should be
compatible enough to make such operations.)"*

This document is that compatibility contract. **It does not build a vector
DB or a graph DB.** It defines chunk boundaries and a node/edge schema for
the existing corpus so that, whenever a real hybrid vector+graph backend is
stood up (see the `v3` roadmap item in
[`docs/adlc-readiness-roadmap.md`](adlc-readiness-roadmap.md)), ingestion is
mechanical rather than a redesign.

The motivating argument (from `Agentic_RAG_Insights.md`, a write-up of
Stephen Chin/Neo4j's "CrabRAG" talk): agents that stuff whole markdown files
into context waste tokens and lose multi-hop relationships; a hybrid
architecture — vector search to find seed chunks, graph traversal to pull
the real neighbors — fixes both. Building that hybrid system is future work
(`v3`); this doc only makes today's corpus ready for it.

## Chunking strategy, by file type already present in this repo

| File type | Path pattern | Chunk boundary | Rationale |
|---|---|---|---|
| Decisions log | `specs/tasks/00-environment-decisions.md`, `specs/tasks/NN-*-decisions.md` | One chunk per `## Decision N: …` heading block | The boundary already exists (append-only structure); no re-authoring needed. |
| OKF single-concept files | `skills/agentic-loop-bootstrap/{principles,phases,questions,artifacts}/*.md` | One chunk per file | OKF's "radical simplicity" design already produces one-concept-per-file boundaries. |
| State files | `specs/tasks/*.state.md` | **Two** chunks per file: (a) stable-fields chunk — frontmatter + status/branch/blocked_on block, (b) growing-log chunk — `agent_log:` entries | The log grows every session; the status block doesn't. Splitting avoids re-embedding the stable half on every update. |
| Task specs | `specs/tasks/0N-<name>.md` | One chunk per file | Consistent with OKF files — task specs are already single-concept documents. |
| Reference docs | `docs/*.md`, `README.md`, `AGENTS.md`, `CLAUDE.md` | One chunk per `##`-level heading section | These are longer, multi-section documents; section-level chunking keeps each chunk focused enough for a useful embedding. |

## Chunk ID scheme
Deterministic IDs, derived as `<file-path>#<heading-anchor>` (e.g.
`specs/tasks/00-environment-decisions.md#decision-11-branch-restructure`).
Two properties this buys:
- **Idempotent re-chunking** — running the chunker again on an unchanged
  file produces the same IDs, so a real ingestion pipeline can diff and
  update rather than re-insert everything.
- **Stable graph nodes across rebuilds** — a node's identity survives a
  content edit as long as the heading text (the anchor) doesn't change;
  heading renames are treated as an explicit node-rename, not silent churn.

## Node/edge schema mapping
No new metadata is invented — this maps what's already in the corpus:
- **Node properties** come directly from existing OKF frontmatter fields:
  `type`, `title`, `provenance`, `source-answers`, plus the chunk's own
  `id` (per the scheme above) and `source_path`.
- **Edges** come from existing markdown links and explicit cross-references
  (e.g. "Referenced by [skill.md](../skill.md)," "see Decision 2 in
  00-environment-decisions.md") — this is exactly what `graphify` already
  extracts today; this schema doesn't change graphify's behavior, it
  documents why that extraction is already compatible.
- **Vector-field placeholder:** every chunk's schema reserves an
  `embedding:` property, left unpopulated until a real vector DB integration
  (`v3`) generates and fills it. No schema migration is needed at that point
  — the field already exists, just empty.

## Explicit non-goals (this document, as of this writing)
- No vector DB or graph DB is installed by this document.
- No embeddings are generated.
- No schema migration runs against the real corpus.
- `graphify`'s current runtime behavior (its own node/edge extraction,
  `graphify-out/graph.json` output) is unchanged — this spec describes
  compatibility with a *future* backend, it does not modify the *current*
  one.

## Where real implementation happens
See the `v3` section of
[`docs/adlc-readiness-roadmap.md`](adlc-readiness-roadmap.md) — a future,
not-yet-scheduled branch where an actual vector+graph DB gets stood up
locally, the chunking pipeline described here gets implemented, the full
corpus gets ingested, and hybrid retrieval gets tested end-to-end against
today's graphify baseline.
