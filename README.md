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

## 📊 Sample Output

```
=== Code Quality Audit Report ===
Generated on: 2026-06-03 21:15:00

📁 FILES ANALYZED (4)
├── src/auth.ts (145 lines modified)
├── utils/helpers.js (67 lines modified)
├── config/settings.json (12 lines modified)
└── styles/theme.css (89 lines modified)

❌ CRITICAL ISSUES (2)
├── auth.ts:34 - Missing error handling in validateToken()
│   Severity: High | Fix: Wrap in try-catch block
│
└── helpers.js:22 - Potential null reference error
    Severity: High | Fix: Add null check before accessing

⚠️  AI-GENERATED CODE INDICATORS (Moderate)
├── Generic variable names (data, result, item, temp)
│   Found in: helpers.js (4 instances)
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
