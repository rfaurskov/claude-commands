#!/bin/bash

# Hook: Listens for "tobetested" keyword in user prompts
# When triggered, injects instructions to add item to TOBETESTED.md

# Read the prompt from Claude Code
input=$(cat)
prompt=$(echo "$input" | jq -r '.prompt')

# Check if prompt contains "tobetested" (case insensitive)
if echo "$prompt" | grep -qi "tobetested"; then
  jq -n '{
    "hookSpecificOutput": {
      "hookEventName": "UserPromptSubmit",
      "additionalContext": "TOBETESTED TRIGGERED: The user mentioned '\''tobetested'\''. Extract the test-related note they described and add it to TOBETESTED.md (in project root) under the \"Test Notes\" section. Format: `- [T-XXXX] (YYYY-MM-DD) note text` where XXXX is a random 4-char alphanumeric ID. After adding, briefly confirm what was logged with its ID."
    }
  }'
else
  echo '{}'
fi

exit 0
