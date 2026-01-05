# Show TOBE Lists

Display the "to be" tracking files based on argument.

**Argument received:** $ARGUMENTS

## Instructions

Based on the argument, show the appropriate file(s):

| Argument | Action |
|----------|--------|
| `fix` | Show contents of `TOBEFIX.md` |
| `test` or `tested` | Show contents of `TOBETESTED.md` |
| `note` or `noted` | Show contents of `TOBENOTED.md` |
| `all` | Show all three files |
| (empty/none) | Show summary of all files (just headers and item counts) |

**For each file shown:**
1. Read the file
2. Display its contents
3. If showing summary only, count items in each section

**Files location:**
- `TOBEFIX.md` - Tasks, bugs, improvements to fix
- `TOBETESTED.md` - Test notes and verified commits
- `TOBENOTED.md` - General notes and observations
