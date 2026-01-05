#!/bin/bash

# Hook: Listens for "tobenoted" keyword in user prompts
# When triggered, injects instructions to add item to TOBENOTED.md

# Read the prompt from Claude Code
input=$(cat)
prompt=$(echo "$input" | jq -r '.prompt')

# Check if prompt contains "tobenoted" (case insensitive)
if echo "$prompt" | grep -qi "tobenoted"; then
  jq -n '{
    "hookSpecificOutput": {
      "hookEventName": "UserPromptSubmit",
      "additionalContext": "TOBENOTED TRIGGERED: The user mentioned '\''tobenoted'\''. Extract the note/observation they described and add it to /home/secureuser/queens/queens-game/TOBENOTED.md under the \"Notes\" section. Format: `- [N-XXXX] (YYYY-MM-DD) note text` where XXXX is a random 4-char alphanumeric ID. After adding, briefly confirm what was logged with its ID."
    }
  }'
else
  echo '{}'
fi

exit 0
