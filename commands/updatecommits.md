# Update Commit Summaries

Backfill missing or stale daily commit summaries in `.commits/` folder.

## Instructions

1. **Get dates with commits:**
   ```bash
   git log --format='%ad' --date=short | sort -u
   ```

2. **Check existing summaries:**
   ```bash
   ls -la .commits/ 2>/dev/null || mkdir -p .commits
   ```

3. **For each date with commits (excluding today):**
   - Check if `.commits/YYYY-MM-DD.md` exists
   - If missing, create it
   - If exists, check if stale (modified before last commit of that day)
   - Get commits for that day:
     ```bash
     git log --format='%h %s' --after='YYYY-MM-DD 00:00' --before='YYYY-MM-DD 23:59:59'
     ```

4. **Summary file format:**
   ```markdown
   # Commits for YYYY-MM-DD

   | Hash | Message |
   |------|---------|
   | abc1234 | Commit message here |
   | def5678 | Another commit |

   ## Summary
   Brief description of what was accomplished this day.
   ```

5. **Skip today's date** - only backfill completed days.

6. **Report what was updated:**
   - List files created
   - List files updated (were stale)
   - List files skipped (already current)
