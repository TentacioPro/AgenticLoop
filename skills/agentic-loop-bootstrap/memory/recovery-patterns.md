---
type: Memory
title: Recovery patterns
description: What to do when things drift, without panic.
tags: [memory, recovery]
---
# Memory: Recovery patterns

## When a decisions file disagrees with the code
The code wins. Append a deviation entry to the decisions file describing
the drift and the corrected decision. Never edit the old decision.

## When a state file's last_verified can't be reproduced
Named discrepancy: flag it in the state file with a `reproduced: no` field
and the actual output you got. Do NOT silently reconcile. This is how the
Ghost Test was caught.

## When the harness's context vanished mid-task
Resume from the state file + repo. The state file's `next_action` is
authoritative. If it's stale, that's a finding to record before continuing.

## When multiple agents disagree
Whoever's read the source most recently wins. Escalate to owner if the
disagreement is about interpretation of a spec — spec authorship is an
owner decision, not an agent negotiation.

## When trunk breaks
Revert the merge that broke it (do not "fix forward" without owner
present). The append-only history captures both the merge and the revert;
that's the record.
