# agentic-loop-bootstrap — OKF bundle

An OKF v0.1 knowledge bundle: markdown files with YAML frontmatter, one required
field (`type`), cross-linked via standard markdown links. Reads on GitHub, ships
as a tarball, mounts on any filesystem, works with Claude Code / OpenClaw /
any agent that reads files.

## What this bundle does
Bootstraps the AgenticLoop methodology into a new project through incremental
conversation. Instead of dumping templates into a folder and hoping, the skill
grills the user for the specific project's constraints (stack, harness, threat
model, verification cadence) and only then generates the tailored setup —
committing every choice into a decisions file so nothing is invisible.

Trigger phrase (from any AGENTS.md-aware harness): `bootstrap agentic loop for
this project` — or, in a fresh empty directory, `set up agentic loop here`.

## Structure
Concept identity = file path with `.md` stripped, per OKF spec.

```
agentic-loop-bootstrap/
├── README.md                       (this file — not a concept, just a landing)
├── skill.md                        [Skill]        entry point + trigger contract
├── phases/
│   ├── 00-context-scan.md          [Phase]        read what's already there
│   ├── 01-grill.md                 [Phase]        incremental questions
│   ├── 02-tailor.md                [Phase]        emit files from answers
│   └── 03-verify.md                [Phase]        prove the setup with tests
├── questions/
│   ├── stack.md                    [Question]     what languages/frameworks
│   ├── harness.md                  [Question]     Claude Code, Kimi, custom…
│   ├── threat-model.md             [Question]     solo, team, public code
│   ├── verify-cadence.md           [Question]     when do owners look
│   └── existing-repo.md            [Question]     greenfield or brownfield
├── artifacts/
│   ├── agents-md.md                [Artifact]     what AGENTS.md becomes
│   ├── claude-md.md                [Artifact]     one-line pointer
│   ├── settings-json.md            [Artifact]     permission profile shape
│   ├── spec-system.md              [Artifact]     00-spec-system.md purpose
│   ├── decisions-log.md            [Artifact]     append-only decisions file
│   ├── state-file.md               [Artifact]     per-task state
│   └── task-spec.md                [Artifact]     the task template
├── principles/
│   ├── provenance-before-confidence.md   [Principle]
│   ├── append-only.md                     [Principle]
│   ├── verify-then-act.md                 [Principle]
│   ├── state-in-repo.md                   [Principle]
│   └── gate-on-merge-result.md            [Principle]
├── memory/
│   ├── lessons-from-real-use.md    [Memory]  what breaks in practice
│   ├── failure-modes.md            [Memory]  named traps
│   └── recovery-patterns.md        [Memory]  what to do when things drift
└── examples/
    └── walkthrough.md              [Example] a fully invented run
```

## How to use
1. Drop this directory into your project's `.claude/skills/` (or wherever the
   harness reads skills).
2. In a fresh session, say: `bootstrap agentic loop for this project`.
3. The skill reads `skill.md`, then runs its four phases in order.
4. When done, your project has AGENTS.md, .claude/settings.json, specs/tasks/
   0-spec-system.md, and a decisions log with every answer you gave — so future
   sessions inherit the choices, not the ambiguity.

## OKF conformance
Every `.md` file below the root has a YAML frontmatter block with at least
`type:`. Cross-links use standard markdown link syntax to concept paths (e.g.
`[grill-phase](phases/01-grill.md)`). No SDK, no runtime, no registry.

## Source
Extracted from the AgenticLoop methodology, validated on foundational backend
security work and one design-decision phase across ~10 days of real use.
NOT validated on data migration, long-term maintenance, or teams >1.
See `memory/lessons-from-real-use.md` for the honest scope.

## License
MIT (inherits from parent repo).
