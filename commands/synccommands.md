# Sync Commands from claude-commands repo

Pull latest commands and hooks from the shared `claude-commands` repository.

## Repository Structure

The claude-commands repo contains:
```
claude-commands/
  commands/     # Slash commands (.md files)
  hooks/        # Event listeners (.sh files)
```

## Instructions

**Pull latest from shared repo:**

```bash
git subtree pull --prefix=.claude https://github.com/rfaurskov/claude-commands.git main --squash
```

**Push local changes to shared repo:**

```bash
git subtree push --prefix=.claude https://github.com/rfaurskov/claude-commands.git main
```

**Note:** The subtree syncs the entire `.claude/` folder (commands + hooks), excluding `settings.json` and `settings.local.json` which are project-specific.

Report what was updated.
