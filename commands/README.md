# Claude Code Commands

Reusable slash commands for Claude Code sessions.

## Available Commands

| Command | Arguments | Purpose |
|---------|-----------|---------|
| `/updatecommits` | - | Backfill daily commit summaries to `commits/` folder |
| `/synccommands` | - | Sync `.claude/` with shared `claude-commands` repo via git subtree |
| `/tobelist` | `fix\|test\|note\|all` | View TOBE* file contents |
| `/tobetest` | `check\|next\|ok <hash>` | Commit verification workflow |
| `/tobepick` | `fix\|test\|quick\|sticky` | Pick 3 task prospects from TOBE* files |
| `/straynotes` | - | Clean up TODO.md, find stray code TODOs |

## Command Details

### /tobelist
Display the "to be" tracking files.

```
/tobelist fix      # Show TOBEFIX.md
/tobelist test     # Show TOBETESTED.md
/tobelist note     # Show TOBENOTED.md
/tobelist all      # Show all three
/tobelist          # Summary with item counts
```

### /tobetest
Commit verification workflow.

```
/tobetest check    # Find new commits since last check
/tobetest next     # Show commits pending review
/tobetest ok abc123 def456  # Mark commits as verified
```

### /tobepick
Pick tasks to work on.

```
/tobepick          # Mix of fix and test items
/tobepick fix      # Only TOBEFIX items
/tobepick test     # Only TOBETESTED items
/tobepick quick    # Prioritize quick tasks
/tobepick sticky   # Include sticky solver item
```

### /updatecommits
Backfill missing daily commit summaries. Run at session start.

### /synccommands
Sync with shared `claude-commands` repo via git subtree pull/push.

### /straynotes
Clean up workflow:
- Find done items in TODO.md
- Find stray `tobefix:` comments in code
- Check for stale references

## Creating New Commands

1. Create `commandname.md` in this folder
2. Use `$ARGUMENTS` placeholder for user arguments
3. Document in CLAUDE.md

Example structure:
```markdown
# Command Name

Brief description.

**Argument received:** $ARGUMENTS

## Instructions

1. Step one
2. Step two

## Arguments

| Argument | Action |
|----------|--------|
| `foo` | Do foo |
| `bar` | Do bar |
```
