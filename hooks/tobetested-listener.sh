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
      "additionalContext": "TOBETESTED TRIGGERED: The user mentioned '\''tobetested'\''. Extract the test-related note they described and add it to /home/secureuser/queens/queens-game/TOBETESTED.md under the \"Test Notes\" section. Format: add a new bullet point with today'\''s date. After adding, briefly confirm what was logged."
    }
  }'
else
  echo '{}'
fi

exit 0
