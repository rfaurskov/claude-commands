# Claude Code Hooks

Event listeners that inject context into Claude Code sessions.

## How Hooks Work

Hooks are shell scripts that:
1. Receive the user prompt as JSON input
2. Pattern-match against keywords
3. Return `additionalContext` to guide Claude's response

## Available Hooks

| Hook | Triggers On | Action |
|------|-------------|--------|
| `tobefix-listener.sh` | "tobefix" | Add/remove/search items in TOBEFIX.md |
| `tobetested-listener.sh` | "tobetested" | Track test notes in TOBETESTED.md |
| `tobenoted-listener.sh` | "tobenoted" | Add notes to TOBENOTED.md |
| `definitions-listener.sh` | definition-related terms | Check/update DEFINITIONS.md |

## tobefix-listener Actions

| Pattern | Action |
|---------|--------|
| "tobefix" + description | ADD item to TOBEFIX.md |
| "tobefix done" / "done tobefix" | REMOVE item from TOBEFIX.md |
| "check tobefix" / "show tobefix" | LIST/SEARCH items |

## Setup

Hooks must be registered in `.claude/settings.json`:

```json
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "\"$CLAUDE_PROJECT_DIR\"/.claude/hooks/tobefix-listener.sh"
          }
        ]
      }
    ]
  }
}
```

## Creating New Hooks

```bash
#!/bin/bash
input=$(cat)
prompt=$(echo "$input" | jq -r '.prompt')

if echo "$prompt" | grep -qi "keyword"; then
  jq -n '{
    "hookSpecificOutput": {
      "hookEventName": "UserPromptSubmit",
      "additionalContext": "Instructions for Claude..."
    }
  }'
else
  echo '{}'
fi

exit 0
```

Make executable: `chmod +x hookname.sh`
