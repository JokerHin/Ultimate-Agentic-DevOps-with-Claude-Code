#!/usr/bin/env bash
# UserPromptSubmit Hook: Intercepts and blocks destructive user prompts

# Claude Code passes the prompt payload via JSON over stdin or via environment/arguments
PROMPT_INPUT="$(cat)"

# Block destructive keywords (case-insensitive)
if echo "$PROMPT_INPUT" | grep -iE '(\bdelete all\b|\bdrop database\b|\brm -rf /\b|\bdestroy production\b|\bdestroy everything\b)' > /dev/null; then
  echo "❌ [BLOCKED by UserPromptSubmit]: Destructive prompt detected. Request rejected for safety." >&2
  exit 1
fi

exit 0