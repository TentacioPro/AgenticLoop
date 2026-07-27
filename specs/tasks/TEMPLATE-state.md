---
provenance: bootstrap-skill-0.1.0
source-answers: [verify-cadence:phase-boundary]
---
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
