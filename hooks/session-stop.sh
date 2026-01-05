#!/bin/bash

# Hook: Stop event
# Auto-updates .claude-resume.md when session ends

# Get recent git activity for context
recent_commits=$(git log --oneline -5 2>/dev/null | head -5)
current_branch=$(git branch --show-current 2>/dev/null)
modified_files=$(git status --porcelain 2>/dev/null | head -10)

# Output instruction to update resume file
jq -n --arg commits "$recent_commits" --arg branch "$current_branch" --arg modified "$modified_files" '{
  "hookSpecificOutput": {
    "hookEventName": "Stop",
    "additionalContext": ("SESSION ENDING: Update .claude-resume.md with:\n- What was accomplished this session\n- Current state and any pending work\n- Recent commits:\n" + $commits + "\n- Branch: " + $branch + (if $modified != "" then "\n- Uncommitted changes:\n" + $modified else "" end))
  }
}'

exit 0
