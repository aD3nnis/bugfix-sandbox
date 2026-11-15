#!/usr/bin/env bash
# PostToolUse hook: runs the linter after Claude edits or writes a file.

LINT_CMD="ruff check ."

case "$LINT_CMD" in
  "<"*) exit 0 ;;
esac

output=$(bash -c "$LINT_CMD" 2>&1)
if [ $? -ne 0 ]; then
  echo "$output" >&2
  exit 2
fi
exit 0
