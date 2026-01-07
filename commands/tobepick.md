# Pick Task from TOBE Lists

Present 3 task prospects from TOBEFIX and TOBETESTED for user to choose from.

**Argument received:** $ARGUMENTS

## Instructions

1. **Read both files:**
   - `docs/TOBEFIX.md` - Tasks, bugs, improvements
   - `docs/TOBETESTED.md` - Test notes section only

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
| (empty) | Mix of TOBEFIX and TOBETESTED items |
| `fix` | Only TOBEFIX items |
| `test` | Only TOBETESTED items |
| `bug` | Only items from Bugs section |
| `feature` | Only items from Features section |
| `quick` | Prioritize quick/simple tasks |
| `sticky` | Include the STICKY section |

## Example Output

**Three prospects:**

1. **[T-3f6y] Test** - How to Play Page: verify touch controls, auto-markers, Daily Challenge link

2. **[F-5m2q] Bug** - MCP integrations check: verify GitHub and Vercel MCP servers work

3. **[F-3c4d] Feature** - Multiplayer stats: wire up real API calls for ELO history and win/loss data
