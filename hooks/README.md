# Claude Code Hooks

Event listeners that inject context into Claude Code sessions.

## How Hooks Work

Hooks are shell scripts that:
1. Receive the user prompt as JSON input
2. Pattern-match against keywords
3. Return `additionalContext` to guide Claude's response

## Available Hooks

### TOBE* Tracking Hooks

| Hook | Triggers On | Action |
|------|-------------|--------|
| `tobefixed-listener.sh` | "tobefix" | Add/remove/search items in docs/TOBEFIXED.md |
| `tobetested-listener.sh` | "tobetested" | Track test notes in docs/TOBETESTED.md |
| `tobenoted-listener.sh` | "tobenoted" | Add notes to docs/TOBENOTED.md |

### Schema Documentation Hooks

| Hook | Triggers On | Action |
|------|-------------|--------|
| `schema-listener.sh` | "update schema" | Provide SCHEMA.md context and domain organization |
| `schema-migration-reminder.sh` | PostToolUse on `apply_migration` | Remind to update SCHEMA.md after migrations |
| `schema-completeness-check.sh` | Every 24h | Audit missing table documentation |

### Other Hooks

| Hook | Triggers On | Action |
|------|-------------|--------|
| `definitions-listener.sh` | definition-related terms | Check/update docs/DEFINITIONS.md |

## tobefixed-listener Actions

| Pattern | Action |
|---------|--------|
| "tobefix" + description | ADD item to docs/TOBEFIXED.md |
| "tobefix done" / "done tobefix" | REMOVE item from docs/TOBEFIXED.md |
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
            "command": "\"$CLAUDE_PROJECT_DIR\"/.claude/hooks/tobefixed-listener.sh"
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

## Hook Types

| Event | When |
|-------|------|
| `UserPromptSubmit` | Before processing user message |
| `PostToolUse` | After a tool completes (use `matcher` to filter by tool name) |
