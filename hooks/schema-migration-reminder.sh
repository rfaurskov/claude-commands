#!/bin/bash
# PostToolUse hook: Remind to update SCHEMA.md after migrations
#
# Triggers after: mcp__supabase__apply_migration
# Purpose: Ensure documentation stays in sync with database changes

# Read tool response from stdin
input=$(cat)

# Extract migration details
migration_name=$(echo "$input" | jq -r '.tool_input.name // "unknown"')
success=$(echo "$input" | jq -r '.tool_response | fromjson | .success // false')

if [ "$success" = "true" ]; then
  cat << 'EOF'
SCHEMA UPDATE REMINDER: Migration applied successfully. Please:

1. Update docs/SCHEMA.md if this migration:
   - Added new tables or columns
   - Renamed or removed columns
   - Changed column types or constraints

2. Check field naming clarity:
   - Is the column name self-explanatory?
   - If ambiguous (like "total_solutions" vs "solution_count"), rename it
   - Add clear description in SCHEMA.md table

3. Update docs/DEFINITIONS.md if this introduces a new concept that needs explanation.

Format for SCHEMA.md columns:
| column_name | type | Description (be specific about what it stores) |
EOF
fi

exit 0
