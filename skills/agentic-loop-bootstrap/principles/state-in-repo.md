---
type: Principle
title: State lives in the repo
description: A non-negotiable rule that shapes every artifact and phase in this bundle.
tags: [principle, ideology]
---
# Principle: State lives in the repo

No agent-local memory, no session scrollback, no IDE state is load-bearing. If an agent's context vanished mid-task, the next agent must resume from the repo alone. This is what makes agents swappable and rate-limit deaths cost nothing.

## Where this shows up
- Referenced by [skill.md](../skill.md) as a behavioral rule.
- Enforced by [phase 2 tailor](../phases/02-tailor.md) when emitting files.
- Recorded in every [decisions log](../artifacts/decisions-log.md) entry.

## Related
See [failure modes](../memory/failure-modes.md) for what happens when this
principle is violated.
