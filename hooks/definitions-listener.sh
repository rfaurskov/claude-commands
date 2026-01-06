#!/bin/bash

# Hook: Listens for definition-related discussions
# When triggered, injects instructions to check/update DEFINITIONS.md

# Read the prompt from Claude Code
input=$(cat)
prompt=$(echo "$input" | jq -r '.prompt')

# Trigger on definition-related terms
if echo "$prompt" | grep -qiE "(defin|algorithm|what is a |how does .* work|canonical|hash|formula|metric|calculation|constraint|coupled)"; then
  jq -n '{
    "hookSpecificOutput": {
      "hookEventName": "UserPromptSubmit",
      "additionalContext": "DEFINITIONS CHECK: If this conversation introduces, modifies, or clarifies a technical term, algorithm, or concept that should be documented, check docs/DEFINITIONS.md. Update existing definitions if they changed, or add new sections for new concepts. Keep format consistent with existing entries (Purpose, Function, Algorithm table, Database column, etc.)."
    }
  }'
else
  echo '{}'
fi

exit 0
