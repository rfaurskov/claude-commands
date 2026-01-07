# Stray Code TODOs

Find stray code comments that should be tracked in TOBE* files.

## Instructions

Perform these checks in order:

### 1. Find Stray Code Comments

Search the codebase for TODO/TOBEFIX/FIXME/PLACEHOLDER comments not tracked in TOBEFIX.md:

```bash
git grep -n -i -E "(TODO|TOBEFIX|FIXME|PLACEHOLDER):" -- ':!node_modules' ':!.next' ':!docs/' ':!commits/'
```

For each found comment:
1. Check if it's already in TOBEFIX.md (by matching description or file reference)
2. If NOT tracked, use AskUserQuestion:
   - "Add this stray item to TOBEFIX.md?"
   - Show: file:line and the comment text
   - Options: "Yes, add to TOBEFIX.md" / "No, it's stale - remove from code" / "Skip"

If adding: Include `(file:line)` reference and place in appropriate section.
If removing from code: Use Edit tool to remove the comment.

### 2. Check for Stale References

For each TOBEFIX.md item that has a `(file:line)` reference:
1. Verify the file still exists
2. Verify the line number is still relevant (content matches)

If stale, use AskUserQuestion:
- "This reference appears stale - update or remove?"
- Options: "Search for new location" / "Remove reference" / "Keep as-is"

### 3. Summary

After all reviews, summarize:
- Stray comments found
- Stray comments added to TOBEFIX.md
- Stray comments removed from code
- Stale references updated

Do NOT auto-commit. Let the user review changes first.
