#!/usr/bin/env bash
# PostToolUse Hook: Logs successful Terraform commands

TOOL_PAYLOAD="$(cat)"

# Filter and log terraform operations
if echo "$TOOL_PAYLOAD" | grep -iE 'terraform' > /dev/null; then
  TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
  echo "[$TIMESTAMP] Terraform execution completed successfully." >> .claude/deploy.log
  echo "📝 [LOGGED by PostToolUse]: Terraform event appended to .claude/deploy.log"
fi

exit 0