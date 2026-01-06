#!/bin/bash

# Hook: Listens for "tobefix" keyword in user prompts
# Actions:
#   - "tobefix" + description → ADD item to TOBEFIX.md
#   - "tobefix done" / "done tobefix" + ID → REMOVE item from TOBEFIX.md
#   - "check tobefix" / "tobefix check" / "what tobefix" → SEARCH/LIST items

# Read the prompt from Claude Code
input=$(cat)
prompt=$(echo "$input" | jq -r '.prompt')

# Check if prompt contains "tobefix" (case insensitive)
if echo "$prompt" | grep -qi "tobefix"; then

  # Check for DONE pattern (remove item)
  if echo "$prompt" | grep -qiE "(tobefix.*done|done.*tobefix|finished.*tobefix|tobefix.*finished|completed.*tobefix|tobefix.*completed)"; then
    jq -n '{
      "hookSpecificOutput": {
        "hookEventName": "UserPromptSubmit",
        "additionalContext": "TOBEFIX DONE: The user marked a tobefix item as done. Find the item in docs/TOBEFIX.md by ID (F-XXXX) or by matching description. Remove the entire line from the file. Confirm what was removed."
      }
    }'

  # Check for CHECK/SEARCH pattern (list or search items)
  elif echo "$prompt" | grep -qiE "(check.*tobefix|tobefix.*check|what.*tobefix|tobefix.*what|show.*tobefix|tobefix.*show|list.*tobefix|tobefix.*list|search.*tobefix|tobefix.*search)"; then
    jq -n '{
      "hookSpecificOutput": {
        "hookEventName": "UserPromptSubmit",
        "additionalContext": "TOBEFIX CHECK: The user wants to see tobefix items. Read docs/TOBEFIX.md and show relevant items. If they mentioned a topic/keyword, filter to matching items. Otherwise show all items with their IDs and sections."
      }
    }'

  # Default: ADD new item
  else
    jq -n '{
      "hookSpecificOutput": {
        "hookEventName": "UserPromptSubmit",
        "additionalContext": "TOBEFIX TRIGGERED: The user mentioned '\''tobefix'\''. Extract the task/issue they described and add it to docs/TOBEFIX.md. Format: `- [F-XXXX] (YYYY-MM-DD) task text` where XXXX is a random 4-char alphanumeric ID. Add under appropriate section. After adding, briefly confirm what was logged with its ID."
      }
    }'
  fi

else
  echo '{}'
fi

exit 0
