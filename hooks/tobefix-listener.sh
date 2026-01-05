#!/bin/bash

# Hook: Listens for "tobefix" keyword in user prompts
# When triggered, injects instructions to add item to TOBEFIX.md

# Read the prompt from Claude Code
input=$(cat)
prompt=$(echo "$input" | jq -r '.prompt')

# Check if prompt contains "tobefix" (case insensitive)
if echo "$prompt" | grep -qi "tobefix"; then
  jq -n '{
    "hookSpecificOutput": {
      "hookEventName": "UserPromptSubmit",
      "additionalContext": "TOBEFIX TRIGGERED: The user mentioned '\''tobefix'\''. Extract the task/issue they described and add it to /home/secureuser/queens/queens-game/TOBEFIX.md. Format: `- [F-XXXX] (YYYY-MM-DD) task text` where XXXX is a random 4-char alphanumeric ID. Add under appropriate section. After adding, briefly confirm what was logged with its ID."
    }
  }'
else
  echo '{}'
fi

exit 0
