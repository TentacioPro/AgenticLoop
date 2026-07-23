# AgenticLoop

AgenticLoop is a spec-driven agentic methodology: a small set of rules for
running coding agents (autonomously or supervised) so that every task is
specified before it's built, every claim of "done" is backed by
reproducible test output, and all state lives in the repo as committed
markdown instead of chat scrollback or agent memory.

The "loop" in the name is the six-step task loop at its core:

```
read → red → green → gate → record → update
```

— read the spec and any prior state, write the failing test first, make
it pass with the smallest sufficient diff, run the full gate (not just
the new test), record the decision (including rejected alternatives),
then update the state file so the next session — or the next agent — can
resume from the repo alone. This naming is TentacioPro's own, coined for
this project; it is unrelated to "loop engineering" as used elsewhere.

See [`docs/methodology-reference.md`](docs/methodology-reference.md) for
the full write-up: the three-actor pattern (owner / agent / gate),
escalation rules, the task-spec and state-file templates, a model
playbook, a prompt-optimizer skill, an autopilot contract for unattended
runs, coexistence rules for sharing a machine safely, and a couple of
meta-observations about where this methodology's shape gets independently
confirmed elsewhere.

## Maturity — read this before adopting

This methodology has been validated on **foundational backend security
work and one design-decision phase, across roughly 10 days of real use.**
It has **not** been validated on:

- Data migrations at scale (schema evolution, back-compat, rollback drills)
- Multi-agent orchestration where agents talk to each other
- Team collaboration with more than one human
- Long-term maintenance (months of use, decision drift)
- Very large codebases (tens of thousands of files or more)
- Regulatory or compliance-heavy environments

If your case falls in that second list, proceed carefully, and consider
contributing what you learn back to
[`skills/agentic-loop-bootstrap/memory/lessons-from-real-use.md`](skills/agentic-loop-bootstrap/memory/lessons-from-real-use.md).
Treat this as an honest v0.1, not a finished framework.

## Quick start

The methodology ships as an [OKF](https://github.com/GoogleCloudPlatform/knowledge-catalog/blob/main/okf/SPEC.md)
(Open Knowledge Format) bootstrap skill — a directory of markdown files
with YAML frontmatter that any agent harness can read.

1. Clone this repo, or copy `skills/agentic-loop-bootstrap/` into your own
   project's `.claude/skills/` directory (or wherever your harness reads
   skills from).
2. In a fresh session on your project, say:

   ```
   bootstrap agentic loop for this project
   ```

3. The skill will scan your existing repo, ask you a handful of questions
   one at a time (stack, harness, threat model, verify cadence, existing
   setup), then generate `AGENTS.md`, `.claude/settings.json`, and the
   `specs/tasks/` scaffolding tailored to your answers — with every choice
   recorded in an append-only decisions log.

## Structure

```
docs/methodology-reference.md         the full methodology writeup
skills/agentic-loop-bootstrap/        the OKF v0.1 bootstrap skill bundle
  skill.md                            entry point + trigger contract
  phases/                             the four-phase bootstrap flow
  questions/                          what the skill asks and why
  artifacts/                          what each generated file becomes
  principles/                         the rules the skill enforces
  memory/                             lessons, failure modes, recovery patterns
  examples/                           a worked walkthrough
```

## License

MIT — see [`LICENSE`](LICENSE).

## Contributing

See [`CONTRIBUTING.md`](CONTRIBUTING.md). The short version: the memory
files (`lessons-from-real-use.md`, `failure-modes.md`) are append-only —
add to them, don't rewrite history.
