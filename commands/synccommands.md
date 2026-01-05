# Sync Commands from claude-commands repo

Pull latest slash commands from the shared `claude-commands` repository.

## Instructions

Run this command to update `.claude/commands/` with the latest from the shared repo:

```bash
git subtree pull --prefix=.claude/commands https://github.com/rfaurskov/claude-commands.git main --squash
```

If you've made local changes to commands that should go back to the shared repo:

```bash
git subtree push --prefix=.claude/commands https://github.com/rfaurskov/claude-commands.git main
```

Report what was updated.
