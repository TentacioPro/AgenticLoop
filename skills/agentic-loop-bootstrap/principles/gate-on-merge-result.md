---
type: Principle
title: Gate on the merge-result commit
description: A non-negotiable rule that shapes every artifact and phase in this bundle.
tags: [principle, ideology]
---
# Principle: Gate on the merge-result commit

Tests passing on a task branch is not enough. The full suite must pass on the commit that results from merging the task branch — that's the commit that actually lands on trunk. Task-branch-only gates miss integration surprises.

## Where this shows up
- Referenced by [skill.md](../skill.md) as a behavioral rule.
- Enforced by [phase 2 tailor](../phases/02-tailor.md) when emitting files.
- Recorded in every [decisions log](../artifacts/decisions-log.md) entry.

## Related
See [failure modes](../memory/failure-modes.md) for what happens when this
principle is violated.
