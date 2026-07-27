---
provenance: bootstrap-skill-0.1.0
source-answers: [threat-model:solo-public-repo]
---
# Rationale for `.claude/settings.json` deny entries

This repo's threat model (Decision 6, `specs/tasks/00-environment-decisions.md`)
is **solo-public-repo**: one person commits/decides, but the repo is public.
`.claude/settings.json` is committed and shared; JSON has no comment syntax,
so the "why" for each deny lives here instead of breeding silent re-additions.

This is not a sandbox — it's a safety net against common accidents and
against a public repo accidentally leaking something.

## solo-local baseline denies
- `git push --force*` / `Remove-Item -Recurse -Force *` / `rm -rf *` /
  `git branch -D*` / `git reset --hard*` — destructive, hard-to-reverse
  operations that should always go through a human, regardless of threat model.
- `git push origin main*` / `git push origin/main*` — direct pushes to the
  default branch should go through the owner, not an agent session.
- `.env` reads (`cat *.env*`, `type *.env*`, `Get-Content *.env*`,
  `Read(.env)`, `Read(.env.*)`) — secrets should never enter a transcript.

## solo-public-repo additions (this repo is public)
- Env printouts (`env`, `printenv*`, `export -p`,
  `Get-ChildItem Env:*` / `gci env:*` / `dir env:*`) — even without a `.env`
  file, a full environment dump can leak tokens, API keys, or local paths
  into a transcript that could end up quoted somewhere public.
- Arbitrary outbound requests (`curl *`, `wget *`, `Invoke-WebRequest *`,
  `Invoke-RestMethod *`) — denied by default because there is no allow-list
  of trusted hosts yet. If a specific host is needed (e.g. a package
  registry), add a scoped allow entry for that host rather than opening
  outbound access generally.

## What's now impossible from within Claude Code
- No direct push to `main`, no force-push, no hard reset, no recursive
  force-delete, no branch `-D`.
- No reading `.env*` files or dumping the process environment.
- No arbitrary `curl`/`wget`/`Invoke-WebRequest`/`Invoke-RestMethod` calls
  without a scoped allow-list addition first.

Everyday ops (git status/diff/log/add/commit, `uv venv`, `uv pip install`,
`graphify`, `python -c`) remain allowed — this profile is about blocking
irreversible or secret-leaking actions, not about blocking normal work.
