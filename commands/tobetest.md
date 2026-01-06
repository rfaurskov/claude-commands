# Commit Testing Workflow

Manage commit verification in `TOBETESTED.md`.

**Arguments:** $ARGUMENTS

## Instructions

Parse the arguments to determine the action:

### `check` - Find new commits and add to pending

1. Read "Last checked" hash from the comment in "Pending Review" section
   - Format: `<!-- Last checked: abc1234 (YYYY-MM-DD) -->`
2. Find all commits since then: `git log --oneline <last_hash>..HEAD`
3. Add new commits to the "Pending Review" section
4. Update the "Last checked" comment with HEAD commit and today's date
5. **Format pending commits as clickable links:**
   ```
   [abc1234](https://github.com/rfaurskov/queens-game/commit/abc1234) - Commit message
   ```
6. Report how many new commits were added

**Output format:**
```
Added X new commit(s) to Pending Review:
- [hash] - [message]
...
```

### `next` - Show commits pending review

1. Read `TOBETESTED.md` "Pending Review" section
2. If empty, check for unverified commits (not in Verified list)
3. Show up to 10 commits needing review, oldest first

**Output format:**
```
Pending review (X commits):

[hash] - [message]
[hash] - [message]
...

Use `/tobetest ok <hash> [hash2] ...` to verify.
```

### `ok <hash> [hash2] [hash3] ...` - Mark commits as verified

1. Parse all commit hashes from arguments (space-separated after "ok")
2. For each hash:
   - Validate it's a real commit: `git log -1 --format='%h - %s' <hash>`
   - If valid, add to `TOBETESTED.md` under "Verified Commits" section
   - Remove from "Pending Review" section if present
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
/tobetest check        - Find new commits, add to pending
/tobetest next         - Show commits pending review
/tobetest ok <hash>    - Mark commit(s) as verified (space-separated)
/tobetest ok abc123 def456 ghi789
```
