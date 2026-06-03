# ai-audit Skill 🔍

Automatically analyzes all uncommitted code changes to identify errors, code quality issues, AI-generated patterns, duplications, and best practice violations.

## What It Does

When you invoke `/ai-audit`, this skill:

1. **Captures all uncommitted changes** — gets the full git diff of your current work
2. **Analyzes for errors** — identifies bugs, logic issues, security vulnerabilities
3. **Detects AI-generated patterns** — looks for signs of AI-generated or boilerplate code
4. **Checks best practices** — validates code against language/framework conventions  
5. **Finds duplication** — identifies repeated code patterns and copy-paste instances
6. **Rates code quality** — provides a detailed assessment with recommendations

## 🚀 Usage

### Basic Invocation

```bash
/ai-audit
```

No arguments needed. The skill automatically analyzes all uncommitted changes in your current git repository.

### When to Use

- **Before committing** — Catch issues early
- **During code review** — Get a comprehensive analysis
- **Learning & improvement** — Understand code quality patterns
- **Team development** — Maintain consistency

## 📊 Output Structure

The skill generates a comprehensive report with:

- **Files Changed** — Count and list of all modified files
- **Errors & Bugs** — Critical issues with severity levels and fixes
- **AI-Generated Code Patterns** — Detected instances of boilerplate or generic code
- **Best Practice Issues** — Code organization, naming, documentation problems
- **Code Duplication Analysis** — Repeated patterns and copy-paste code
- **Quality Metrics** — Overall score (1-10), error density, duplication index
- **Actionable Recommendations** — Prioritized list of improvements

## 🔍 What Gets Analyzed

### Error Detection
- Missing error handling (`try/catch`, promise rejection)
- Null/undefined reference bugs
- Type mismatches
- Security vulnerabilities
- Logic errors and edge cases
- Async/await issues
- Resource leaks

### AI-Generated Code Indicators
- Generic variable names (`data`, `result`, `item`, `temp`, `obj`)
- Boilerplate code patterns
- Over-commenting on obvious code
- Verbose naming conventions
- Unnecessary wrapper functions
- Placeholder implementations
- Repetitive patterns

### Best Practices
- Function length (recommended: < 50 lines)
- Code complexity metrics
- Documentation completeness
- Naming consistency
- Error handling patterns
- Code organization
- Separation of concerns

### Code Duplication
- Identical code blocks
- Similar patterns across files
- Repeated utility functions
- Copy-paste instances
- Logic duplication

## 📋 Examples

### Example 1: Simple Check

```bash
/ai-audit
```

**Output:**
```
Files analyzed: 3
Quality score: 7/10
Issues: 1 (low priority)
```

### Example 2: Complex Analysis

```bash
/ai-audit
```

**Output:**
```
=== Code Quality Audit ===

📁 Files: 8 modified
❌ Critical Issues: 2
⚠️  Warnings: 4  
AI-Generated: 35%
Duplication: 8%
Quality Score: 5.5/10

[Detailed breakdown follows...]
```

## ✅ Requirements

- ✓ Must be in a git repository (`git init` to start)
- ✓ Must have uncommitted changes (staged or unstaged)
- ✓ Claude Code needs git command permissions
- ✓ Works with any programming language
- ✓ Works with mixed language projects

## 🔧 Advanced Features

### Language Support
- JavaScript/TypeScript
- Python
- Go
- Rust
- Java
- C/C++
- And more...

### Report Types
- **Basic** — Summary only
- **Detailed** — Includes code snippets
- **Visual** — Formatted with priorities

### Configuration (Optional)
Create `.ai-audit-config.json` in your project:
```json
{
  "ignorePaths": ["node_modules", "dist"],
  "severityThreshold": "medium",
  "aiGeneratedThreshold": 0.4
}
```

## 🛠️ Implementation Details

This skill uses:
- `git diff HEAD` — captures all uncommitted changes
- `git status` — identifies modified files
- Claude's advanced code analysis
- Pattern recognition for AI-generated code detection
- Best practice databases for multiple languages
- Duplication detection algorithms

## 💡 Tips & Tricks

### Tip 1: Pre-Commit Workflow
```bash
# Make changes
code .

# Before committing, run
/ai-audit

# Fix issues, then
git commit -m "..."
```

### Tip 2: Code Review Prep
```bash
# Analyze before requesting review
/ai-audit

# Use findings to improve code quality
```

### Tip 3: Learning
```bash
# Run on your code to understand patterns
/ai-audit

# Review AI-generated indicators to improve code
```

## 📚 Report Fields Explained

| Field | Meaning |
|-------|---------|
| Quality Score | 1-10 rating of code quality |
| Error Density | Percentage of error-prone code |
| AI-Generated % | Likelihood of AI-generated code |
| Duplication % | Amount of duplicate code |
| Files Changed | Number of modified files |

## 🚨 Severity Levels

- **Critical** — Will cause runtime errors or security issues
- **High** — Bad practices that will cause problems
- **Medium** — Code quality issues that should be fixed
- **Low** — Suggestions for improvement

## 🐛 Error? No Uncommitted Changes?

```bash
# Check current status
git status

# Make a change
echo "test" >> file.txt

# Try again
/ai-audit
```

## 🔗 Related Skills

- `/code-review` — In-depth code review with multiple dimensions
- `/simplify` — Code simplification and optimization
- `/verify` — Run and verify your code changes
- `/grill-me` — Interview about your design decisions

## 📖 Documentation

For detailed documentation, see `README.md` in this skill's folder.

---

**Version:** 1.0.0  
**Last Updated:** 2026-06-03  
**Author:** You  
**License:** MIT
