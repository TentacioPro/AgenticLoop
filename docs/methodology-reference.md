# Methodology Reference

**Source:** This document is synthesized from the working notes, task specs,
state files, and decision logs that produced the AgenticLoop methodology.
It has been extracted and rewritten to remove anything project-specific —
repo names, file paths, personal names/places, tool/vendor choices tied to
a particular stack. What remains is the generic pattern: a six-step task
loop, its supporting templates, and the operating rules learned from
running it. If a wording choice here seems arbitrary, it is: read it as
"the shape that worked," not as the one true form.

**Redactions:** This reference intentionally omits anything that was
personal to the source project rather than general to the methodology —
personal goals/roadmaps, feature wishlists, third-party repo inventories,
and UI/design-system decisions specific to one product. Only the
operating rules for running agentic work are kept.

---

## 1. The three actors

Every task loop runs with three distinct roles, and conflating them is
where most drift starts:

- **Owner** — the human. Sets scope, holds veto over anything destructive
  or irreversible (touching a trunk branch, deleting branches, force-push,
  weakening a test, spending real money/credentials), and is the only
  actor allowed to resolve a genuine ambiguity. The owner does not
  micromanage the loop step-by-step — they set the FILE SCOPE and DONE
  MEANS once, then get pulled back in only at a stop condition.
- **Agent** — the coding agent (any harness). Executes the six-step loop
  strictly inside its task's FILE SCOPE, updates the state file at every
  step boundary, and never claims something works without pasted,
  reproducible command output. An agent that can't reproduce a state
  file's last recorded verification treats that as a named discrepancy,
  not something to silently paper over.
- **Gate** — not a person: the test suite plus the self-review checklist
  that a task must pass before it is "done." The gate is what makes
  "done" checkable instead of a claim. A task green in isolation but red
  after merge is not done — the gate re-runs on the merge result, not
  just the branch.

The loop only works if these three stay separate: the owner doesn't do
the agent's job (defeats the point of delegating), the agent doesn't
grant itself the owner's authority over irreversible actions, and nothing
is "done" on the agent's say-so alone — only the gate decides that.

## 2. Escalation rules

An agent operating autonomously must stop and hand control back to the
owner — writing the exact question into the task's state file rather than
guessing — under these conditions:

1. The same gate fails twice for the same underlying cause (don't loop
   variations blindly on the third+ attempt).
2. The task would touch a protected/trunk branch or delete a branch.
3. A spec contradiction or file-scope conflict is discovered.
4. Secrets are involved beyond local, write-only generation (never print
   a secret; never read a committed `.env`).
5. A per-task tool-call/time budget is exceeded.
6. Making a test pass would require weakening what it asserts — this is
   **always** a stop, no exceptions. A weakened test is worse than a
   failing one because it hides the failure instead of reporting it.

When headless/unattended, the same rules apply with one change: on a stop
condition, the agent records `blocked_on` in the state file, commits and
pushes what's safe, and moves to the next non-conflicting queue item
instead of idling — an idle wait overnight costs the same as a crash, so
never wait, always either advance something else or exit cleanly.

## 3. Model playbook

Practices that hold regardless of which model/vendor is driving the
agent:

- Attach the task spec and state file, not the whole repo. Context files
  beat pasted context — this is most of the token-efficiency story.
- One task per session. A fresh session per task beats one long session;
  stale context causes more failed tool calls than a weaker model does.
- Ask for structured output ("return fields a, b, c") over free prose —
  it parses more reliably on every model family.
- Low temperature (near 0) for code/tool work, regardless of vendor.
- Always give the model an explicit out: "if uncertain, say so and stop."
  A hallucinated success is the most expensive failure mode there is,
  because it isn't visible until much later.

Per-family notes go stale fast (models update faster than any static doc
can track), so treat vendor-specific practices as a pointer to "check the
current official docs for this model family," not as a frozen table.
Route by task shape, not price: architecture/ambiguous-scope work goes to
the highest-capability tier available; mechanical red→green work
(renames, small fixes) is fine on a cheaper/faster tier; anything
touching security or data migration is never routed by price alone — a
cheap model's silent mistake there costs more than the tokens it saved.

## 4. The task spec template

Every task is written as a spec **before** any code, using this shape:

```markdown
## GOAL
One checkable outcome.

## MODULE SPECS
Which living spec(s) this task reads or updates.

## REUSE MAP
What existing code/patterns this task should reuse, and where they live.

## TDD CONTRACT
Which tests go red first, and what "green" means concretely.

## GUARDRAIL-PROVENANCE
Any check/rule this task relies on, with where that rule came from.

## FILE SCOPE
Exact directories/files this task may touch. Anything outside scope is a
violation, not initiative — parallel tasks depend on scopes staying
disjoint.

## OUT OF SCOPE
Explicitly what this task does NOT do (prevents scope creep disguised as
thoroughness).

## DONE MEANS
The tests/commands that must pass, and the artifacts that must exist,
before this task can be marked done.
```

Two spec layers, both markdown, both versioned:

- A **living** layer, one file per concern/module — edited only when a
  numbered task drives the change, with the commit referencing the task.
- An **append-only chronological ledger** — one file per task (the ask,
  written first), a companion `-decisions.md` (mandatory on completion,
  includes rejected alternatives and why), and a `-learnings.md` when
  something non-obvious surfaced. Nothing in the ledger is ever edited
  after the fact — corrections are new entries, not silent rewrites.

## 5. The state file template

Every in-progress task has a state file, updated at every loop-step
boundary and committed alongside the work:

```markdown
# State: <task-name>
status: not_started | in_progress | blocked | review | done
loop_step: read | red | green | gate | record | update
branch: task/<name>
last_verified: <paste of the last full test-run output, with timestamp>
next_action: <one concrete sentence — what the next session does first>
blocked_on: <only if status=blocked — the exact question or missing input>
agent_log: <one line per session: date, which agent, what moved>
```

Rule: **all state lives in the repo as committed markdown.** No
agent-local memory, no chat scrollback, no IDE-only state is ever
load-bearing. If an agent's context vanishes mid-task, the next agent (or
the same one tomorrow) must be able to resume from the repo alone.

Switching agents or resuming after a gap: read the entry point file, then
the task spec, then the state file, then re-run `last_verified` yourself
before trusting it — a state file's claims are trusted only after being
reproduced, never taken on faith. A `last_verified` that can't be
reproduced is itself a finding: name the discrepancy in the state file,
don't silently proceed as if it matched.

## 6. The six-step loop

```
read → red → green → gate → record → update
```

1. **read** — read the task spec, the relevant module specs, and (if
   resuming) the state file's `last_verified` claim; reproduce it before
   trusting it.
2. **red** — name the failing test(s) first. Code without a preceding red
   is the most common source of untested "done" claims.
3. **green** — make it pass with the smallest sufficient diff. Drive-by
   refactors ("improving while you're there") are scope drift, and scope
   drift is where unrelated tests break.
4. **gate** — run the full relevant suite, not just the new test. A merge
   gate is serialized and re-runs on the merge result, never "branch was
   green so the merge is fine."
5. **record** — write the decisions file: choices made, rejected
   alternatives, and any deviation from the original spec, named
   explicitly.
6. **update** — update the state file (status, `last_verified`,
   `next_action`) and commit it with the code. Nothing is "paused"
   without a state-file update — an unrecorded pause is indistinguishable
   from lost work to the next session.

## 7. Master prompt template (session opener)

The first message of any session should establish, once, rather than be
re-negotiated every session:

```
PHASE A — PERMISSIONS (do this first, present as ONE checklist, then wait)
- Exact shell/filesystem scope you may operate in.
- Auth needed (and how it will be provided — never paste a token into
  chat; auth flows the owner runs themselves).
- Git identity to commit as.
- Any installs you intend to run, listed explicitly for yes/no.
- What is NEVER touched without a per-action explicit go (protected
  branches, force-push, branch deletion, history rewrites).
- Secrets policy: never write credentials into a file; example/template
  files only, filled in by the owner.

PHASE B — SETUP (after confirmation)
Concrete, ordered steps to stand up the environment/workspace.

PHASE C — BASELINE VERIFICATION (never skip, never summarize away)
Run the existing verification commands; paste the REAL output; call out
any deviation from expectation by name — a mismatch is a finding to
report, never something to quietly fix or normalize unprompted.

PHASE D — STOP LINE
Print the state, the deviation list (or "none"), and a one-line proposal
for the next task. Then stop. Do not begin work without explicit go.

STANDING RULES
Never claim something works without pasted output. If a step is
ambiguous, state the chosen interpretation in one line and proceed —
except anything in the Phase A "never touch without a go" list, which
always waits.
```

## 8. Prompt optimizer

A companion skill: before executing a rough instruction, rewrite it into
this shape (target ≤20 lines), show the rewrite, then execute *that*:

```
GOAL: <one checkable outcome>
CONTEXT: <files to read first, exact paths — never "the codebase">
SCOPE: <files/dirs allowed to change> | OUT: <explicitly untouchable>
VERIFY-FIRST: <1-3 commands to run before changing anything>
PLAN: <3-7 numbered steps, each ending in a checkable state>
DONE MEANS: <tests/commands that must pass + artifacts that must exist>
REPORT: <what to paste back: output tails, diffs, state-file update>
BUDGET: <max tool calls/time before stopping to report>
```

Rules this bakes in: verify-then-act (read/run before editing from
memory); absolute paths and exact names, never a guessed path; batch
reads and prefer one coherent edit per file over many micro-edits; forbid
drive-by refactors; red before green; prefer idempotent commands; update
the state file at every plan step so a crash loses one step, not the
session; stop after two consecutive failures of the same approach rather
than looping variations; label anything not read from a file or command
output this session as an assumption, never a fact; return output tails,
not restated file contents.

## 9. Autopilot contract

For unattended/autonomous execution, the standing session opener is a
contract, not a suggestion:

> You are authorized to execute the queue autonomously, task by task,
> without stopping for approval, under this contract:
>
> **Allowed without asking:** everything inside a task's FILE SCOPE
> following the six-step loop; branch creation; commits; pushes of
> non-protected branches; serialized merges that pass the full gate;
> state-file and decisions-file writes; re-running suites; starting/
> stopping services the task itself owns.
>
> **Must stop** (see §2 Escalation rules) and write the question into
> `blocked_on`, then move to the next non-conflicting item — never
> idle-wait.
>
> **Per-session hygiene:** one task per session; export/clear context
> between tasks; update the state file at every loop-step boundary so any
> future session can resume from the repo alone.
>
> **Self-review before marking any task done:** every changed assertion
> is stronger or equal, never weaker; no bypass/env-conditional paths
> around a check; the decisions file names choices, rejected
> alternatives, and deviations; the full gate output is pasted into the
> state file; metrics are filled in. Only then: done.

Per-task metrics worth recording (cheap now, becomes a real signal once
aggregated across many tasks):

```
metrics:
  tool_calls_used: N (budget N)
  gate_runs: N  gate_failures: N (cause per failure, one line)
  tests_added: N  tests_strengthened: N  tests_weakened: 0   # must be 0
```

## 10. Coexistence rules

An autonomous/unattended agent is a guest on a shared machine, not the
owner of it:

1. **Kill only what you started, by PID.** Never kill by name, pattern,
   or port lookup — a name/port match can hit an unrelated process
   belonging to something else entirely. Every process the agent starts
   records its PID at spawn; teardown reads that PID, verifies the
   command line still matches before killing, then deletes the record.
2. **Port preflight, never evict a foreign occupant.** Before starting
   any service, check who currently owns the port. Free → start yours,
   record the PID. Owned by your own recorded (crash-leftover) PID →
   reuse or restart it. Owned by anything else → do not touch it; record
   a `blocked_on` naming the conflict and move to unaffected work instead
   of "fixing" it by changing a hardcoded port or config unprompted.
3. **Resource courtesy.** Preflight heavy steps against available memory/
   CPU; defer rather than starve the rest of the machine. Prefer lower
   parallelism for long unattended runs — slow and correct beats fast and
   disruptive when nobody is watching.
4. **Exit-clean invariant.** The last act of every invocation — success,
   blocked, or budget-exhausted — is tearing down only what you started,
   confirming nothing owned by you is still running, and leaving anything
   foreign exactly as found. After an unattended run, the machine state
   should look like only your commits happened.
5. **Never, even under an autonomy contract:** touch a protected/trunk
   branch, run a data migration, delete a branch, weaken a test, or edit
   a secrets file. Anything requiring one of these is a stop, not a
   judgment call.

## 11. Meta-observation

Two observations from outside this project, recorded because they
independently confirmed pieces of this methodology rather than because
they inspired it:

- **Durable, versioned "skill" files that travel across tasks — instead
  of re-explaining context every session — are structurally the same
  move as this methodology's entry-point file + task specs.** The gap
  worth naming: none of this self-improves from outcomes automatically.
  A methodology built this way stays only as good as its append-only
  memory files (lessons, failure modes) — which means those files are
  worth curating deliberately, not treated as an afterthought log.
- **Continuous measurement of agent performance in production — where
  "blind spots" are precisely the places tests don't look, and a
  merged/shipped rate is the honest metric over vibes — maps directly
  onto why the gate re-runs on the merge result and why metrics are
  recorded per task.** A green-looking suite that still hid a real bug
  (because the assertion was checking the wrong thing) is the concrete
  shape of a blind spot: **test output is a claim about the environment,
  not a claim about the code — both need to be verified, not just one.**

The general pattern: when an external framework independently arrives at
the same shape as a rule you already learned the hard way, that's
evidence the rule generalizes past your specific case — worth raising its
priority, not dismissing as redundant.
