#!/bin/bash
# UserPromptSubmit hook: Periodic schema completeness check
#
# Runs at most once per 24 hours to verify all DB tables are documented in SCHEMA.md
# Reads table list from SCHEMA.md comment: <!-- TABLES: table1,table2,... -->

TIMESTAMP_FILE="$CLAUDE_PROJECT_DIR/.claude/.schema-check-timestamp"
SCHEMA_FILE="$CLAUDE_PROJECT_DIR/docs/SCHEMA.md"
CURRENT_TIME=$(date +%s)
CHECK_INTERVAL=86400  # 24 hours in seconds

# Check if we should run (first run or >24h since last check)
if [ -f "$TIMESTAMP_FILE" ]; then
  LAST_CHECK=$(cat "$TIMESTAMP_FILE")
  TIME_DIFF=$((CURRENT_TIME - LAST_CHECK))
  if [ $TIME_DIFF -lt $CHECK_INTERVAL ]; then
    exit 0
  fi
fi

# Update timestamp
echo "$CURRENT_TIME" > "$TIMESTAMP_FILE"

# Extract table list from SCHEMA.md
TABLE_LINE=$(grep -o '<!-- TABLES: [^>]*-->' "$SCHEMA_FILE" | head -1)
if [ -z "$TABLE_LINE" ]; then
  echo "SCHEMA CHECK: Could not find <!-- TABLES: ... --> in SCHEMA.md"
  exit 0
fi

# Parse tables from comment
TABLES=$(echo "$TABLE_LINE" | sed 's/<!-- TABLES: //' | sed 's/ -->//' | tr ',' '\n')

# Check which tables are missing documentation
MISSING=()
for table in $TABLES; do
  if ! grep -q "### ${table}" "$SCHEMA_FILE" && ! grep -q "### ${table} table" "$SCHEMA_FILE"; then
    MISSING+=("$table")
  fi
done

if [ ${#MISSING[@]} -gt 0 ]; then
  echo "SCHEMA COMPLETENESS CHECK (daily):"
  echo "Tables missing documentation in SCHEMA.md:"
  for t in "${MISSING[@]}"; do
    echo "  - $t"
  done
fi

exit 0
