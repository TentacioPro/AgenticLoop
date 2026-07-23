---
type: Principle
title: Append-only
description: A non-negotiable rule that shapes every artifact and phase in this bundle.
tags: [principle, ideology]
---
# Principle: Append-only

Decisions files, audit logs, and state history are appended, never mutated. Corrections are new entries referencing the old, not edits. This is what makes 'why did we do X?' answerable months later.

## Where this shows up
- Referenced by [skill.md](../skill.md) as a behavioral rule.
- Enforced by [phase 2 tailor](../phases/02-tailor.md) when emitting files.
- Recorded in every [decisions log](../artifacts/decisions-log.md) entry.

## Related
See [failure modes](../memory/failure-modes.md) for what happens when this
principle is violated.
