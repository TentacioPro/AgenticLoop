---
type: Artifact
title: specs/tasks/00-environment-decisions.md (target file)
description: The append-only log of every environment/methodology decision.
tags: [artifact, target-file, decisions]
target-path: specs/tasks/00-environment-decisions.md
consumes: [all-questions]
---
# Artifact: 00-environment-decisions.md

## Purpose
Every question answered in Phase 1 becomes an entry. Every future decision
(new tool, new rule, new deviation) appends here. Never edited in place.

## Emission
By the time Phase 2 runs, this file already has one entry per answered
question — Phase 1 wrote them as it went. Phase 2's job is to append the
final "Decisions #N+1: initial bootstrap complete" record with:
- SHA of the commit that lands the bootstrap
- List of artifact files emitted
- Any question deferred + why

## Rules
- Append-only. See [principle: append-only](../principles/append-only.md).
- Every entry: title, chosen, rejected (with one-line reason each), rationale,
  timestamp.
- Corrections are new entries referencing the old number, never edits.
