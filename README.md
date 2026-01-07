# Claude Code Configuration

This folder contains Claude Code customizations: slash commands, hooks, and specialized agents.

## Structure

```
.claude/
├── commands/     # Slash commands (/tobepick, /tobelist, etc.)
├── hooks/        # Event listeners (tobefix, tobetested, schema)
├── agents/       # Specialized subagents (game-logic-tester, code-review)
└── settings.json # Hook configuration
```

## Quick Reference

### Commands
| Command | Purpose |
|---------|---------|
| `/updatecommits` | Backfill daily commit summaries |
| `/synccommands` | Sync with claude-commands repo |
| `/tobelist` | View TOBE* file contents |
| `/tobetest` | Commit verification workflow |
| `/tobepick` | Pick 3 task prospects |
| `/tobestray` | Find stray code TODOs |

### Hooks
| Hook | Triggers |
|------|----------|
| `tobefixed-listener` | "tobefix" keyword |
| `tobetested-listener` | "tobetested" keyword |
| `tobenoted-listener` | "tobenoted" keyword |
| `definitions-listener` | Definition-related terms |
| `schema-*` | Schema/migration related |

### Agents
| Agent | Use Case |
|-------|----------|
| `game-logic-tester` | Rigorous game logic verification |
| `code-review-advisor` | Code quality and best practices |

## Subtree Sync

This folder syncs with `rfaurskov/claude-commands` repo:

```bash
# Pull updates
git subtree pull --prefix=.claude https://github.com/rfaurskov/claude-commands.git main --squash

# Push changes
git subtree push --prefix=.claude https://github.com/rfaurskov/claude-commands.git main
```

## See Also

- `commands/README.md` - Detailed command documentation
- `hooks/README.md` - Hook creation guide
- `agents/README.md` - Agent specifications
