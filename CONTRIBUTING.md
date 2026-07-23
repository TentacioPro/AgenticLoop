# Contributing

Contributions are welcome — this is an honest v0.1, validated on a narrow
slice of real use (see the Maturity section in the [README](README.md)),
and it gets better as more people apply it to different projects and
report back what broke.

## Ways to contribute

- **Report what didn't fit.** If you applied this methodology (or the
  bootstrap skill) to a project and something in it didn't hold up, that's
  exactly the kind of finding this project wants. Open an issue, or add
  directly to the relevant memory file (see below) and send a PR.
- **Improve the bootstrap skill.** `skills/agentic-loop-bootstrap/` is an
  [OKF](https://github.com/GoogleCloudPlatform/knowledge-catalog/blob/main/okf/SPEC.md)
  bundle — plain markdown with YAML frontmatter. New concepts need a
  `type:` field in frontmatter and should cross-link via standard markdown
  links, consistent with the existing files.
- **Extend the methodology reference.** `docs/methodology-reference.md`
  should stay generic — patterns and rules, not any one project's
  specifics. If your addition only makes sense with your project's
  context attached, it probably belongs in your own fork's notes, not
  here.

## The append-only convention (required)

`skills/agentic-loop-bootstrap/memory/lessons-from-real-use.md` and
`skills/agentic-loop-bootstrap/memory/failure-modes.md` are **append-only**.
This mirrors the methodology's own decisions-log rule: a correction is a
new entry, not a silent rewrite of an old one.

- **Do:** add a new entry under the "Lessons/failures added by adopters"
  section (create it at the bottom of the file if it doesn't exist yet).
- **Don't:** edit or delete an existing entry, even if you believe it's
  wrong or outdated. If a documented lesson turns out to be incomplete or
  situational, add a new entry noting the exception — the history of what
  was believed and when is part of the value.

PRs that rewrite existing entries in these two files (rather than
appending) will be asked to split the change: revert the edit, add a new
entry instead.

## Sanitization

Everything in this repo is public. Before submitting a PR, check that any
example, log excerpt, or walkthrough you're adding doesn't contain real
project names, credentials, internal paths, or anything else specific to
your own environment — keep examples generic or clearly fictional, the
way `examples/walkthrough.md` already is.

## Pull requests

Small, focused PRs are easier to review than large ones. If you're
proposing a structural change to the methodology itself (not just an
addition to the memory files), open an issue first to discuss — the
six-step loop and the three-actor pattern are load-bearing for everything
else in this repo, so changes there deserve discussion before code.
