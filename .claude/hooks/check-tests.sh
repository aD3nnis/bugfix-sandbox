#!/usr/bin/env bash
# Stop hook: runs the tests when Claude tries to finish. If they fail, Claude keeps working.
# It blocks only once in a row: if Claude tries to finish again, it is allowed to.

TEST_CMD="<test command>"

case "$TEST_CMD" in
  "<"*) exit 0 ;;
esac

# Claude Code sends the hook a JSON object on stdin. "stop_hook_active" is true
# when Claude is already continuing because a Stop hook blocked it. Letting it
# stop then prevents an endless loop when a test can't be fixed.
input=$(cat)
if echo "$input" | grep -q '"stop_hook_active"[[:space:]]*:[[:space:]]*true'; then
  exit 0
fi

output=$(bash -c "$TEST_CMD" 2>&1)
if [ $? -ne 0 ]; then
  echo "Tests are failing. Fix them, or tell the user why they fail, before you finish." >&2
  echo "$output" | tail -n 50 >&2
  exit 2
fi
exit 0
