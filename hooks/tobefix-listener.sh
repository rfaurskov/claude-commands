#!/bin/bash

# Hook: Listens for "tobefix" keyword in user prompts
# When triggered, injects instructions to add item to TOBEFIX.md

# Read the prompt from Claude Code
input=$(cat)
prompt=$(echo "$input" | jq -r '.prompt')

# Check if prompt contains "tobefix" (case insensitive)
if echo "$prompt" | grep -qi "tobefix"; then
  cat << 'EOF'
{
  "continue": true,
  "additionalContext": "TOBEFIX TRIGGERED: The user mentioned 'tobefix'. Extract the task/issue they described and add it to /home/secureuser/queens/queens-game/TOBEFIX.md. Format: add a new bullet point under the appropriate section (or create a section if needed). Include today's date. After adding, briefly confirm what was logged."
}
EOF
else
  echo '{"continue": true}'
fi
