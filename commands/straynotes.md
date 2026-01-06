# Stray Notes Cleanup

Clean up TODO.md and find stray code comments that should be tracked.

## Instructions

Perform these checks in order:

### 1. Review Done Items in TODO.md

Read `docs/TODO.md` and find any items marked as done (checkboxes `[x]`, strikethrough, or "DONE"/"COMPLETE" text).

For each done item, use AskUserQuestion to ask:
- "Remove this completed item from TODO.md?"
- Show the item text
- Options: "Yes, remove" / "No, keep for reference"

### 2. Find Stray Code Comments

Search the codebase for TODO/TOBEFIX/FIXME/PLACEHOLDER comments not tracked in TODO.md:

```bash
git grep -n -i -E "(TODO|TOBEFIX|FIXME|PLACEHOLDER):" -- ':!node_modules' ':!.next' ':!docs/' ':!commits/'
```

For each found comment:
1. Check if it's already in TODO.md (by matching description or file reference)
2. If NOT tracked, use AskUserQuestion:
   - "Add this stray item to TODO.md?"
   - Show: file:line and the comment text
   - Options: "Yes, add to TODO.md" / "No, it's stale - remove from code" / "Skip"

If adding: Include `(file:line)` reference and place in appropriate section.
If removing from code: Use Edit tool to remove the comment.

### 3. Check for Stale References

For each TODO.md item that has a `(file:line)` reference:
1. Verify the file still exists
2. Verify the line number is still relevant (content matches)

If stale, use AskUserQuestion:
- "This reference appears stale - update or remove?"
- Options: "Search for new location" / "Remove reference" / "Keep as-is"

### 4. Summary

After all reviews, summarize:
- Items removed from TODO.md
- Stray comments added to TODO.md
- Stray comments removed from code
- Stale references updated

Do NOT auto-commit. Let the user review changes first.
