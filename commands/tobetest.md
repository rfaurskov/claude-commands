# Commit Testing Workflow

Manage commit verification in `TOBETESTED.md`.

**Arguments:** $ARGUMENTS

## Instructions

Parse the arguments to determine the action:

### `next` - Show unverified commits

1. Get recent commits: `git log --oneline -30`
2. Read `TOBETESTED.md` and extract verified commit hashes
3. Compare and show commits NOT in the verified list
4. Group by category if possible (UI changes, scripts, fixes, etc.)
5. Show max 10 unverified commits, oldest first

**Output format:**
```
Unverified commits (X total):

[hash] - [message]
[hash] - [message]
...

Use `/tobetest ok <hash> [hash2] ...` to mark as verified.
```

### `ok <hash> [hash2] [hash3] ...` - Mark commits as verified

1. Parse all commit hashes from arguments (space-separated after "ok")
2. For each hash:
   - Validate it's a real commit: `git log -1 --format='%h - %s' <hash>`
   - If valid, add to `TOBETESTED.md` under "Verified Commits"
3. Add commits to the END of the verified list (before the closing ```)
4. Format: `<hash> - <commit message>`
5. Confirm what was added

**Output format:**
```
Verified X commit(s):
- [hash] - [message]
- [hash] - [message]
```

### No arguments or `help`

Show usage:
```
/tobetest next         - Show unverified commits
/tobetest ok <hash>    - Mark commit(s) as verified (space-separated)
/tobetest ok abc123 def456 ghi789
```
