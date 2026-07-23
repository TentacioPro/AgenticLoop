---
type: Artifact
title: Task state file template
description: Per-task pause/resume handoff document.
tags: [artifact, template]
target-path: specs/tasks/TEMPLATE-state.md
---
# Artifact: State file template

## Emit as `specs/tasks/TEMPLATE-state.md`
```markdown
# State: NN-<task-name>
status: not_started | in_progress | blocked | review | done
loop_step: read | red | green | gate | record | update
branch: task/NN-<name>
last_verified: |
  <paste the exact test output that last ran green, with timestamp>
next_action: <one sentence — what a resuming session does first>
blocked_on: <only populated if status=blocked — exact question or missing input>
agent_log:
  - <YYYY-MM-DD · agent-name · what moved>
metrics:
  tool_calls_used: N (budget from task spec)
  gate_runs: N   gate_failures: N (cause per failure)
  tests_added: N   tests_strengthened: N   tests_weakened: 0   # MUST be 0
```

## Rules
- Updated at every loop-step boundary and committed with the code.
- `last_verified` is pasted output, not narrative. If it says "tests pass"
  without output, it's an unverified claim.
- `tests_weakened > 0` is an immediate stop trigger.
