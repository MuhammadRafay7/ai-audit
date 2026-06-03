# ai-audit Skill 🔍

Automatically analyzes all uncommitted code changes to identify errors, code quality issues, AI-generated patterns, duplications, and best practice violations in your project.

## 🎯 Features

- **Error Detection** — Identifies bugs, logic errors, security vulnerabilities, and syntax issues
- **AI-Generated Code Patterns** — Detects signs of AI-generated or generic code:
  - Generic/boilerplate patterns
  - Over-commenting
  - Verbose variable naming
  - Unnecessary abstractions
  - Copy-paste patterns
  - Placeholder implementations
- **Best Practices Checker** — Validates code against language and framework conventions
- **Duplication Analysis** — Finds repeated code patterns and copy-paste instances
- **Code Quality Rating** — Provides a 1-10 score with actionable recommendations
- **Multi-language Support** — Works with JavaScript, TypeScript, Python, Go, Rust, and more

## 📦 Installation

### Option 1: Local Installation (Recommended)

1. Clone or download this skill into your Claude Code skills directory:

```bash
# For macOS/Linux
mkdir -p ~/.claude/skills
git clone https://github.com/yourusername/ai-audit ~/.claude/skills/ai-audit

# For Windows
mkdir %USERPROFILE%\.claude\skills
git clone https://github.com/yourusername/ai-audit %USERPROFILE%\.claude\skills\ai-audit
```

2. Restart Claude Code (or reload in VS Code extension)

3. Start using the skill with `/ai-audit`

### Option 2: Add to Your Project

Copy the `ai-audit` folder into your project's `.claude/skills/` directory:

```bash
cp -r ai-audit your-project/.claude/skills/
```

### Option 3: Manual Installation

1. Download the files from this repository
2. Create a folder at `~/.claude/skills/ai-audit/`
3. Copy `SKILL.md` and `README.md` into that folder
4. Restart Claude Code

## 🚀 Quick Start

```bash
/ai-audit
```

That's it! The skill analyzes all your uncommitted changes automatically.

## 📊 What Gets Analyzed

The skill examines:
- ✅ All modified files in your working directory
- ✅ Staged changes (`git add`)
- ✅ Unstaged changes (modified but not staged)
- ✅ File deletions (marked for deletion)
- ✅ New files
- ✅ All language types (JS, TS, Python, Go, Rust, etc.)

## 📋 Requirements

- Must be in a git repository (`git init` if needed)
- Changes must be uncommitted
- Claude Code must have git permissions

## 📊 How It Actually Works

**Important:** ai-audit is NOT a script or compiled tool. It's a Claude Code skill that:

1. **Runs via Claude** — Uses Claude's AI to analyze your code
2. **Interprets SKILL.md** — Follows detailed instructions in SKILL.md file
3. **Analyzes git diff** — Examines your uncommitted changes
4. **Generates reports** — Provides structured analysis with recommendations

**Quality depends on:**
- ✅ How good the SKILL.md instructions are
- ✅ Claude's current capabilities
- ⚠️ Complexity of your code
- ⚠️ What's realistically detectable by AI (not 100% accurate)

**What it CAN reliably find:**
- Obvious bugs (missing null checks, unhandled errors)
- Code patterns (duplicated logic, long functions)
- Naming issues (generic variable names)
- Basic best practice violations

**What it CAN'T reliably find:**
- Subtle architectural problems
- Complex performance issues
- Language-specific edge cases
- Business logic errors

## 📊 Sample Output

See realistic examples: [`docs/sample-outputs.md`](docs/sample-outputs.md)

Here's what a typical analysis looks like:

```
=== CODE QUALITY AUDIT ===

📁 FILES ANALYZED: 3 files
├── src/auth.ts (89 lines)
├── utils/helpers.js (45 lines)
└── config/settings.json (23 lines)

❌ ERRORS FOUND (1)

auth.ts:34 - Missing error handling
  Problem: await validateToken() not wrapped in try-catch
  Impact: Unhandled promise rejection if validation fails
  Fix: Wrap with try-catch block

⚠️  AI-GENERATED PATTERNS (Moderate 40%)
- Generic names: result, data, item (4 instances in helpers.js)
- Boilerplate try-catch pattern repeated 2x identically
- Over-commenting on obvious code (2 instances)

📈 QUALITY METRICS
├── Overall Score: 6.5/10
├── Critical Issues: 1
├── Warnings: 3
├── AI-Generated Likelihood: 40%
└── Duplication: 8%

💡 TOP PRIORITIES
1. [CRITICAL] Add error handling to auth.ts:34
2. Rename generic variables for clarity
3. Extract duplicate error patterns

✨ ASSESSMENT
Code has solid structure but needs error handling fix and some cleanup.
Ready to commit after addressing the critical issue.
│
├── Over-commenting on simple functions
│   Found in: auth.ts (2 instances)
│
├── Boilerplate error handling patterns
│   Found in: auth.ts, helpers.js (3 instances)
│
└── Unnecessary abstraction layers
    Found in: config/settings.json (1 instance)

📋 BEST PRACTICE VIOLATIONS (3)
├── Function too long (auth.ts:45 - 78 lines)
│   Recommendation: Split into smaller functions
│
├── Missing JSDoc comments on exports (helpers.js:5)
│   Recommendation: Add documentation
│
└── Inconsistent error handling patterns
    Recommendation: Use consistent strategy

🔄 CODE DUPLICATION (2)
├── validateEmail() appears 2x
│   Files: helpers.js:15, auth.ts:62
│   Action: Extract to shared utility
│
└── Configuration validation logic duplicated
    Files: config/settings.json
    Action: Use shared validator

📈 QUALITY METRICS
├── Overall Code Quality: 6.5/10
├── Error Density: 2 critical in 313 lines
├── AI-Generated Likelihood: 45%
├── Code Duplication: 12%
└── Best Practice Compliance: 70%

💡 RECOMMENDATIONS
1. [HIGH] Fix error handling in auth.ts
2. [MEDIUM] Refactor long functions  
3. [MEDIUM] Extract duplicate validateEmail logic
4. [LOW] Rename generic variables
5. [LOW] Add documentation comments

✨ Summary
Your changes need attention to error handling. Review AI-generated patterns manually.
```

## 🔧 Configuration (Optional)

Create `.ai-audit-config.json` in your project root to customize:

```json
{
  "ignorePaths": ["node_modules", "dist", "build"],
  "analyzeUnstagedOnly": false,
  "severityThreshold": "medium",
  "aiGeneratedThreshold": 0.3,
  "enableDetailedReport": true
}
```

**Options:**
- `ignorePaths` — Paths to skip
- `analyzeUnstagedOnly` — Only unstaged changes (default: false)
- `severityThreshold` — Minimum issue level (low, medium, high)
- `aiGeneratedThreshold` — AI confidence threshold (0-1)
- `enableDetailedReport` — Include code snippets (default: true)

## 💡 Use Cases

### Before Committing Code
```bash
/ai-audit
# Review issues and AI-generated patterns before git commit
```

### Code Review Prep
```bash
/ai-audit
# Get a full analysis before requesting code review
```

### Learning & Improvement
```bash
/ai-audit
# Understand code quality issues and best practices
```

### Team Development
```bash
/ai-audit
# Catch issues before they reach production
```

## 🐛 Troubleshooting

| Issue | Solution |
|-------|----------|
| "Not in a git repository" | Run `git init` in your project |
| "No uncommitted changes" | Modify a file first or run `git status` |
| Skill not found | Restart Claude Code or reload VS Code |
| Too many false positives | Increase `aiGeneratedThreshold` in config |
| Slow analysis | Try `.ai-audit-config.json` with `ignorePaths` |

## 📚 Analysis Checks Explained

### Error Detection
- Missing error handling
- Null/undefined references
- Type mismatches
- Security issues
- Logic errors
- Async/await problems

### AI-Generated Patterns
- Generic names (data, result, item, temp)
- Boilerplate code
- Over-commenting
- Verbose naming
- Unnecessary wrappers
- Placeholder code

### Best Practices
- Function length (< 50 lines recommended)
- Complexity metrics
- Documentation
- Naming consistency
- Error patterns
- Code organization

### Duplication
- Identical blocks
- Similar patterns
- Repeated utilities
- Copy-paste code

## ⚠️ Limitations & Expectations

### What This Skill Actually Is
- A **helper tool**, not a complete solution
- An **AI-powered code reviewer**, with human-like limitations
- A **pre-commit check** to catch obvious issues
- A **learning tool** to understand patterns and best practices

### Accuracy & Limitations
- **~70-80% accurate** for obvious bugs and errors
- **~60-70% accurate** for code quality issues
- **~50-60% accurate** for AI-generated code detection (heuristic-based)
- **NOT accurate** for architectural or complex performance issues

### Known Limitations
- Can't analyze language-specific edge cases perfectly
- May produce false positives/negatives on AI detection
- Depends on Claude's current capabilities
- Won't catch subtle business logic errors
- May miss context-dependent issues

### Best Used For
- **Quick pre-commit sanity checks**
- **Catching obvious bugs before review**
- **Understanding code patterns**
- **Learning best practices**
- **First-pass analysis** (not final review)

### NOT a Replacement For
- Thorough code review by humans
- Automated linters (ESLint, Pylint, etc.)
- Type checkers (TypeScript, mypy)
- Security audits
- Performance profiling

### Tips for Best Results
1. **Use with other tools** — Combine with ESLint, TypeScript, tests
2. **Run before submitting PR** — Catch issues early
3. **Use for learning** — Review recommendations and understand why
4. **Set realistic expectations** — It's good but not perfect
5. **Trust your instinct** — Override suggestions if you disagree

---

## 🤝 Contributing

Improvements welcome!

1. Fork the repository
2. Create a branch: `git checkout -b feature/improvement`
3. Make changes and test
4. Submit a pull request

### Ideas
- Add language-specific rules
- Improve AI detection
- Add performance analysis
- Create visual reports
- CI/CD integration

## 📄 License

MIT License - Use freely in your projects

## 🔗 Related

- `/code-review` — In-depth code review
- `/simplify` — Code simplification
- `/verify` — Run & verify changes

## 📞 Support

- Found a bug? Open an issue on GitHub
- Have suggestions? Submit a pull request
- Need help? Check the troubleshooting section above

---

**Made with ❤️ for developers who want cleaner, smarter code**

Last Updated: 2026-06-03 | Version: 1.0.0
# ai-audit
