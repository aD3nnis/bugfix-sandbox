#!/usr/bin/env bash
# Stop hook: runs the tests when Claude tries to finish. If they fail, Claude keeps working.

TEST_CMD="<test command>"

case "$TEST_CMD" in
  "<"*) exit 0 ;;
esac

output=$(bash -c "$TEST_CMD" 2>&1)
if [ $? -ne 0 ]; then
  echo "Tests are failing. Fix them before you finish." >&2
  echo "$output" | tail -n 50 >&2
  exit 2
fi
exit 0
