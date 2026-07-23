---
type: Artifact
title: .claude/settings.json (target file)
description: Permission profile tailored to the threat-model answer.
tags: [artifact, target-file, permissions]
target-path: .claude/settings.json
consumes: [threat-model, stack, harness]
---
# Artifact: .claude/settings.json

## Purpose
Allow the day-to-day operations agents need; deny everything that could
cascade if the agent makes a mistake.

## Templates by threat-model answer

### solo-local (accident-prevention profile)
Broad allow for typical dev ops (git, test runners, package managers, docker,
edit/write). Deny only truly dangerous: force-push, delete-branch, rm-rf,
Remove-Item -Recurse, .env reads (Bash and Read tool both), push to main.
The user acknowledges: THIS IS NOT A SANDBOX. It's a safety net against
common accidents.

### solo-public-repo
solo-local + additional deny on any command that could leak secrets to logs
(env printouts, curl to external hosts without allow-list).

### small-team
solo-public-repo + deny all merges (owner does merges by hand or via PR).

### public-with-contributors
Most restrictive: read/edit/write/test allowed; no git operations at all
(all commits, branches, pushes go through the human).

## Rules for emission
- Never emit `.env` in any list. Never allow `cat *.env*`, `type *.env*`,
  `Get-Content *.env*`.
- Include comments in the JSON (as a `// ...` field if the harness allows,
  or a sibling `.claude/settings.rationale.md` if not) explaining why each
  deny entry is there. Silent denies breed re-additions.
- If the stack answer is python-heavy, allow-list should include `uv *` and
  `python *`. This is a DECISION — record it as "arbitrary interpreter
  access, threat-model acknowledged."
- After emission, tell the user which category of permissions was chosen and
  what's now impossible from within Claude Code (they should NOT be surprised
  later).
