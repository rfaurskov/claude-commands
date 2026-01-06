# Update Commit Summaries

Backfill missing or stale daily commit summaries in `.commits/` folder.

## Instructions

1. **Get dates with commits:**
   ```bash
   git log --format='%ad' --date=short | sort -u
   ```

2. **Check existing summaries:**
   ```bash
   ls -la .commits/
   ```

3. **For each date with commits (excluding today):**
   - Check if `.commits/commits-YYYY-MM-DD.md` exists
   - If missing, create it
   - If exists, check if stale by comparing file modification date to the date in the filename:
     - Extract date from filename: `commits-2026-01-03.md` → `2026-01-03`
     - Get file's modification date from `ls -la` output
     - **STALE if:** file modification date ≤ date in filename (was generated before midnight)
     - **OK if:** file modification date > date in filename (was generated after that day ended)
   - Get commits for that day (use --reverse for chronological order):
     ```bash
     git log --format='%h %s' --after='YYYY-MM-DD 00:00' --before='YYYY-MM-DD 23:59:59' --reverse
     ```

4. **Summary file format** (follow `.commits/commits-2026-01-01.md` as reference):
   ```
   COMMITS SUMMARY - YYYY-MM-DD
   ============================

   Total: NN commits

   ================================================================================
   SECTION NAME (e.g., FEATURE AREA)
   ================================================================================

   abc1234 - Commit message here
   def5678 - Another related commit

   NEW FILES:
     - path/to/file.ts          (Brief description)
     - path/to/another.tsx      (What it does)

   MODIFIED:
     - src/components/Foo.tsx   (What changed)

   DATABASE:
     - table_name table
     - another_table view

   TO TEST:
     [ ] Test item 1
     [ ] Test item 2

   ================================================================================
   ANOTHER SECTION
   ================================================================================
   ... more commits grouped by feature/area ...
   ```

   **Key principles:**
   - Group commits by feature/area (not chronological flat list)
   - Include NEW FILES, MODIFIED, DATABASE sections where relevant
   - Add TO TEST checklists for testable features
   - Use `================` separators between sections

5. **Skip today's date** - only backfill completed days.

6. **Report what was updated:**
   - List files created
   - List files updated (were stale)
   - List files skipped (already current)
