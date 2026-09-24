#!/bin/sh
# Measures how much context a session loads before any work starts.
# Usage: sh scripts/thinness.sh [repo-root]   (read-only; prints a table)
root="${1:-.}"; cd "$root" || exit 1
router=AGENTS.md
[ -f "$router" ] || { echo "no $router"; exit 1; }
# Files the router tells the agent to read: Read `path`
reads=$(grep -o 'Read `[^`]*`' "$router" | sed 's/Read `//;s/`$//')
states=$(ls specs/tasks/*.state.md 2>/dev/null | head -1)
total=0
printf '%-48s %6s %8s\n' FILE LINES BYTES
for f in "$router" CLAUDE.md $reads $states; do
  [ -f "$f" ] || continue
  l=$(wc -l < "$f"); b=$(wc -c < "$f"); total=$((total+b))
  printf '%-48s %6s %8s\n' "$f" "$l" "$b"
done
echo "mandatory read path: $total bytes (~$((total/4)) tokens)"
echo "router lines: $(wc -l < "$router")  (budget 60)"
echo "always-read files over 150 lines:"
for f in $reads $states; do [ -f "$f" ] && [ "$(wc -l < "$f")" -gt 150 ] && echo "  $f"; done
echo "duplicate-policy check: CLAUDE.md lines = $(wc -l < CLAUDE.md 2>/dev/null) (budget 5)"
