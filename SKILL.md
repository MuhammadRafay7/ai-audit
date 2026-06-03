# ai-audit Skill 🔍

Analyzes all uncommitted code changes to identify errors, code quality issues, AI-generated patterns, duplications, and best practice violations.

## ⚡ How It Works

When you invoke `/ai-audit`:

1. Get the current git diff: `git diff HEAD` (all uncommitted changes)
2. Extract and examine the code for issues (see sections below)
3. Generate a structured audit report
4. Present findings with priorities and recommendations

## 🔎 Analysis Framework

Your report MUST include these sections, in this order:

### 1. FILES CHANGED
- List each modified file with line count
- Format: `filename (X lines modified)`
- Include new files and deletions

### 2. ERRORS & BUGS (Critical)
Search for actual code bugs:
- **Null/Undefined checks**: Missing null checks before `.property` access
- **Error handling**: Async/await without try-catch, unhandled promise rejections, missing try-catch blocks
- **Type errors**: Type mismatches (passing string where number expected, etc.)
- **Logic errors**: Obvious logical fallacies (unreachable code, always-true conditions, off-by-one errors)
- **Security issues**: Hardcoded credentials, SQL injection risks, XSS vulnerabilities
- **Resource leaks**: Unclosed files, connections, event listeners
- **Async issues**: race conditions, missing awaits, callback hell

For EACH issue found, report:
```
File:Line - [CRITICAL/HIGH/MEDIUM] Issue title
Problem: Specific description
Impact: What breaks/goes wrong
Fix: How to fix it
```

### 3. AI-GENERATED CODE PATTERNS (Detection)
Look for specific AI generation indicators:

**Generic Variable Names** (strong indicator):
- `data`, `result`, `item`, `temp`, `obj`, `val`, `x`, `res`, `resp`
- `config`, `options`, `params`, `args` (without context)
- Count instances and list files

**Boilerplate/Template Code** (strong indicator):
- Identical error handling in multiple places
- Cookie-cutter try-catch blocks with same structure
- Repeated initialization patterns
- Template comments like "TODO: implement", placeholder code

**Over-Commenting** (moderate indicator):
- Comments that just restate code: `// increment i` above `i++`
- Comments on obvious operations: `// create user` above `const user = new User()`
- Excessive comments on short, clear functions

**Verbose/Awkward Naming** (weak-moderate indicator):
- Names like `getUserByIdAndFetchTheirProfile` (should be shorter)
- Redundant suffixes: `userData`, `userList`, `userArray` (data type in name)
- Stuttering: `httpServer`, `serverInstance` (repeats concept)

**Unnecessary Abstractions** (moderate indicator):
- Wrapper functions that add no value: `function getData() { return data; }`
- Excessive interfaces/types for simple operations
- Multi-layer abstraction for simple task

Report as:
```
AI-GENERATED LIKELIHOOD: [Low 0-30% | Moderate 30-60% | High 60-90%]

Indicators found:
- Generic names: item, data, result (3+ occurrences in file.js)
- Boilerplate: try-catch pattern repeated 2x identically (file.ts:15, file.ts:42)
- Over-commenting: Function descriptions above simple operations (2 instances)
```

### 4. BEST PRACTICE VIOLATIONS
Language and framework conventions:

**Function/Method Length**:
- Flag functions over 50 lines
- Report: `file:line - Function name is X lines (recommended <50)`

**Naming Consistency**:
- camelCase vs snake_case mixing in same file
- Constants not in UPPER_CASE
- File names not matching exports

**Documentation**:
- Public/exported functions without documentation
- Missing parameter descriptions
- No return type documentation

**Error Handling**:
- Inconsistent error handling patterns (some try-catch, some if-error-check)
- Silently catching errors: `catch(e) {}` with no logging
- Generic error messages

**Code Organization**:
- Mixed concerns in single function
- Imports at bottom instead of top
- Logic mixed with presentation (if applicable)

### 5. CODE DUPLICATION
Identify repeated code patterns:

Search for:
- **Identical functions**: Same logic in multiple files → extract to utils
- **Repeated validation logic**: Email validation, password validation patterns appearing 2+ times
- **Copy-paste code blocks**: Identical 5+ line blocks in different locations
- **Similar patterns**: `for` loops with same structure, similar object creation

Report format:
```
DUPLICATION FOUND:

Pattern: [description]
Files: file1.js:line, file2.ts:line, file3.py:line
Type: [identical/similar/repeated-pattern]
Action: Extract to shared utility OR refactor common logic
```

### 6. QUALITY SCORE & SUMMARY

Provide a **single overall score: 1-10**

Scoring guide:
- 9-10: Excellent (few issues, clean code)
- 7-8: Good (some minor issues, acceptable)
- 5-6: Fair (multiple issues, needs work)
- 3-4: Poor (significant problems, major refactoring needed)
- 1-2: Critical (blocking issues, don't commit)

Include:
- What went well
- What needs attention
- Top 3 priority fixes

## 📋 Output Format

Structure your response as:

```
=== CODE QUALITY AUDIT ===
[Date/time if available]

📁 FILES ANALYZED: X files
├── file1.js (45 lines)
├── file2.ts (89 lines)
└── file3.py (23 lines)

[SECTION 2: Errors & Bugs - only if found]

[SECTION 3: AI-Generated Patterns - only if found]

[SECTION 4: Best Practices - only if found]

[SECTION 5: Duplication - only if found]

📈 QUALITY METRICS
├── Overall Score: X/10
├── Critical Issues: X
├── Warnings: X
├── AI-Generated Likelihood: X%
└── Duplication Level: X%

💡 TOP PRIORITIES
1. [Highest priority fix]
2. [Second priority]
3. [Third priority]

✨ SUMMARY
[One paragraph assessment]
```

## ⚙️ Implementation Rules

**MUST DO:**
- ✓ Get uncommitted changes (git diff or git status)
- ✓ Examine actual code, not just filenames
- ✓ Report with specific file:line references
- ✓ Provide actionable recommendations
- ✓ Be honest about confidence levels

**MUST NOT DO:**
- ✗ Make up issues that don't exist
- ✗ Report all possible improvements (focus on actual issues)
- ✗ Ignore language-specific considerations
- ✗ Use vague descriptions ("refactor this")
- ✗ Claim 100% accuracy on AI detection (it's heuristic-based)

**BE REALISTIC:**
- Acknowledge if changes look clean
- Note if AI detection is uncertain
- Don't over-analyze minor code style issues
- Focus on real problems that affect functionality

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
