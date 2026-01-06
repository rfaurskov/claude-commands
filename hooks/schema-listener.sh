#!/bin/bash
# UserPromptSubmit hook: Catch schema-related requests
#
# Triggers on: User mentions schema, table names, column explanations
# Purpose: Provide context about SCHEMA.md location and format

# Read user prompt from stdin
input=$(cat)
prompt=$(echo "$input" | jq -r '.prompt // ""' | tr '[:upper:]' '[:lower:]')

# Check for schema-related keywords
if echo "$prompt" | grep -qiE '(update schema|schema\.md|explain.*(column|field|table)|document.*(table|column)|add.*to schema|schema update)'; then
  cat << 'EOF'
SCHEMA DOCUMENTATION CONTEXT:

Location: docs/SCHEMA.md

When updating schema documentation:
1. Find the relevant domain section (or create one)
2. Use this column format:
   | column_name | type | Clear description of what it stores |

3. Organize tables by domain:
   - PUZZLE DOMAIN: puzzles, puzzle_cells, puzzle_solutions, puzzle_metrics, puzzle_tags, puzzle_sizes, block_types, block_type_*
   - USER DOMAIN: user_profiles, user_audit_log, user_puzzle_stats, guest_players, gameplay_sessions, gameplay_actions
   - SYSTEM DOMAIN: roles, permissions, role_permissions, site_settings, countries
   - Reference tables: difficulty_levels, technique_levels, techniques, puzzle_quality_thresholds, color_palettes
   - Feedback: feedback_reports, feedback_responses

4. For ambiguous field names:
   - Consider renaming the column (via migration) to be self-explanatory
   - Examples of good names: solution_count, created_at, is_published
   - Examples of bad names: total, flag, data, value

5. If the column represents a new concept, also add to docs/DEFINITIONS.md

6. Update the Table Index comment with new tables:
   <!-- TABLES: table1,table2,... -->
EOF
  exit 0
fi

exit 0
