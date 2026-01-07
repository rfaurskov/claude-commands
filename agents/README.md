# Claude Code Agents

Specialized subagents invoked via the Task tool for focused work.

## Available Agents

### game-logic-tester

**Purpose:** Rigorous, methodical testing of game logic, mathematical calculations, and data validation.

**Use when:**
- Verifying puzzle solver correctness
- Testing canonical hash functions
- Validating game rules implementation
- Checking database consistency

**Invocation:**
```
Task tool with subagent_type='game-logic-tester'
```

**Key behaviors:**
- Stays strictly on task
- Reports clear PASS/FAIL/INCONCLUSIVE verdicts
- Provides specific next steps when blocked

---

### code-review-advisor

**Purpose:** Code quality review and best practices verification.

**Use when:**
- After implementing significant features
- Before pushing game logic changes
- Reviewing recent commits
- Checking for security issues

**Invocation:**
```
Task tool with subagent_type='code-review-advisor'
```

**Key behaviors:**
- Reviews code quality proactively
- Runs relevant tests for game logic changes
- Suggests improvements and refactoring

---

## Creating New Agents

Agent files use YAML frontmatter:

```markdown
---
name: agent-name
description: When to use this agent and example invocations
model: sonnet  # or opus, haiku
---

System prompt content here...
```

### Frontmatter Fields

| Field | Required | Description |
|-------|----------|-------------|
| `name` | Yes | Identifier for the agent |
| `description` | Yes | When/how to invoke (shown in Task tool) |
| `model` | No | Model to use (default: inherits) |

### Writing Good Agent Prompts

1. **Define clear scope** - What this agent does and doesn't do
2. **Set behavioral rules** - How it should respond
3. **Include project context** - Key files, conventions, rules
4. **Specify output format** - How results should be structured
