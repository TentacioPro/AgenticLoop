---
type: Artifact
title: CLAUDE.md (target file)
description: One-line pointer file so Claude Code's auto-load lands on AGENTS.md.
tags: [artifact, target-file]
target-path: CLAUDE.md
consumes: [harness]
---
# Artifact: CLAUDE.md

## Purpose
Claude Code auto-reads CLAUDE.md at session start. Point it at AGENTS.md so
there's ONE source of truth.

## Template (exactly)
```markdown
See AGENTS.md. (Pointer only — never duplicate content; two copies drift.)
```

## When to skip
If the harness answer is "not-claude-code," emit nothing. AGENTS.md alone
suffices for other harnesses.
