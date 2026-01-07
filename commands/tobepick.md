# Pick Task from TOBE Lists

Present 3 task prospects from TOBEFIX and TOBENOTED for user to choose from.

**Argument received:** $ARGUMENTS

## Instructions

1. **Read both files:**
   - `docs/TOBEFIXED.md` - Tasks, bugs, improvements
   - `docs/TOBENOTED.md` - Notes and observations

2. **Filter out completed items:**
   - Skip items marked ~~strikethrough~~ (done/fixed)
   - Skip items with "DONE" or "FIXED" in the text
   - Skip the STICKY section unless specifically requested

3. **Select 3 varied prospects:**
   - Try to pick from different categories (bug, feature, test, improvement)
   - Prefer actionable items over investigations
   - Consider the argument for filtering (see below)

4. **Present options clearly:**
   Format each as:
   ```
   1. **[ID] Category** - Brief description of what needs doing
   2. **[ID] Category** - Brief description
   3. **[ID] Category** - Brief description
   ```

## Arguments

| Argument | Filter |
|----------|--------|
| (empty) | Mix of TOBEFIX and TOBENOTED items |
| `fix` | Only TOBEFIX items |
| `note` | Only TOBENOTED items |
| `bug` | Only items from Bugs section |
| `feature` | Only items from Features section |
| `quick` | Prioritize quick/simple tasks |
| `sticky` | Include the STICKY section |

## Example Output

**Three prospects:**

1. **[F-5m2q] Bug** - MCP integrations check: verify GitHub and Vercel MCP servers work

2. **[F-3c4d] Feature** - Multiplayer stats: wire up real API calls for ELO history and win/loss data

3. **[N-7p8q] Note** - PuzzleCard modal layout improvements needed
