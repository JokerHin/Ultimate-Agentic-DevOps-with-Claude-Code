#!/usr/bin/env bash
TOOL_PAYLOAD="$(cat)"

if echo "$TOOL_PAYLOAD" | grep -iE '(terraform.*destroy|rm -rf|drop database)' > /dev/null; then
  echo "🚫 [BLOCKED by PreToolUse]: Execution of destructive commands like 'terraform destroy' is strictly prohibited." >&2
  exit 2
fi

exit 0