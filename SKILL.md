---
name: ai-audit
description: Analyze uncommitted code changes for errors, code quality issues, and AI-generated patterns
---
# ai-audit Skill

⚠️ **Status: Alpha, Unvalidated**

Framework for analyzing uncommitted code changes.
Not tested on real code. Heuristics are theoretical.
Help validate by testing and reporting results.

See [VALIDATION.md](../VALIDATION.md) to contribute testing results.

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

### AI Detection: Context-Aware Heuristics

**IMPORTANT:** Not all generic names = AI-generated. Context matters heavily.

**Generic Variable Names** (WEAK indicator alone, needs context):

❌ **High likelihood (multiple weak signals):**
- `const data = apiResponse` (generic name for complex data)
- `const result = performCalculation()` (unclear what result is)
- `let item; for (item of items)` (item is redundant, could be just variable)
- `const temp = transform(input)` (temp name, suggests placeholder)
- **COMBINED with:** verbose comments, boilerplate patterns, placeholder code

✅ **LEGITIMATE use (NOT AI-generated):**
- `const data = JSON.parse(json)` (data is the parsed JSON, context is clear)
- `const result = Promise.all([...])` (result of async operation, clear)
- `for (const item of items)` (standard loop pattern, idiomatic)
- `const config = loadConfig()` (loading config, context is clear)
- `const response = await fetch()` (HTTP response, standard naming)
- **Pattern:** Generic name makes sense in context, used once or twice

**Decision rule:** Flag only if:
1. **Multiple instances** (5+ uses of data/result/item in file) AND
2. **Non-obvious context** (unclear what data/result refers to) AND
3. **Other indicators present** (boilerplate, over-commenting, etc.)

---

**Boilerplate/Template Code** (strong indicator if identical):

❌ **High likelihood:**
- **Identical try-catch blocks** in 2+ places with exact same structure
  ```javascript
  try {
    const result = await operation();
    return result;
  } catch (error) {
    console.log(error);
  }
  ```
  If seen verbatim 2+ times: **Strong AI indicator**

- **Cookie-cutter initialization** repeated exactly
- **Template comments:** "TODO: implement", "FIXME", "placeholder"
- **Dummy/stub code** that doesn't do real work

✅ **LEGITIMATE similar patterns (NOT AI-generated):**
- Similar try-catch *structure* but different operations inside
- Repeating framework boilerplate (Django, React, Spring patterns)
- Standard error handling that's used consistently (good practice)
- Idiomatic language patterns (every Promise needs .catch() etc)

**Decision rule:** Flag only if:
1. **Near-identical code** (>80% match) appears 2+ times AND
2. **NOT explained by framework/pattern** AND
3. **Could be extracted to function** but wasn't

---

**Over-Commenting** (moderate indicator if excessive):

❌ **High likelihood:**
```javascript
// Get the user by ID
const user = getUser(id);

// Check if user exists
if (!user) {
  // Return error
  return error;
}

// Return the user
return user;
```
Every line has comment restating obvious code.

✅ **LEGITIMATE comments (NOT AI-generated):**
```javascript
// User ID is from JWT, validate signature first
const user = getUser(id);

// Fetch from cache to avoid DB hit
if (!user) {
  user = await fetchFromCache(id);
}
```
Comments explain *why*, not restate *what*.

**Decision rule:** Flag only if:
1. **Comment-to-code ratio >1:2** (more comments than code) AND
2. **Comments restate code** (don't add information) AND
3. **Trivial operations commented** (obvious what's happening)

---

**Verbose/Awkward Naming** (weak indicator):
- `getUserByIdAndFetchTheirProfile` → better as `fetchUserProfile`
- `userData`, `userList`, `userArray` → should be just `users` or `user`
- `serverInstance`, `httpServer` → stuttering
- BUT: Could also be developer being overly explicit (not necessarily AI)

**Decision rule:** Only flag if combined with other indicators.

---

**Unnecessary Abstractions** (moderate indicator):
```javascript
// Strong AI indicator:
function getData() {
  return data;  // Wrapper that adds no value
}

// Legitimate pattern:
function getUserWithDefaults() {
  return { ...defaultUser, ...loadedUser };  // Adds logic
}
```

**Decision rule:** Flag only if wrapper functions serve no purpose.

---

### Scoring AI-Generated Likelihood

**Use a weighted scoring approach:**

| Indicator | Strength | Points |
|-----------|----------|--------|
| Identical code block (2+ places) | Strong | +40 |
| Generic names (5+ with unclear context) | Weak | +15 |
| Boilerplate pattern repeated identically | Strong | +35 |
| Over-commenting (>1:2 ratio) | Moderate | +25 |
| Template comments ("TODO", "FIXME") | Strong | +30 |
| Unnecessary wrapper functions | Moderate | +20 |

**Total Score Interpretation:**
- 0-20 points: Low (0-30%)
- 20-50 points: Moderate (30-60%)
- 50-80 points: High (60-80%)
- 80+ points: Very High (80%+)

**IMPORTANT:** 
- Only count if indicators are INDEPENDENT
- Ignore if explained by framework/pattern/language idiom
- Always note confidence level and uncertainty
- **Default to skeptical:** "Could be AI, but also could be legitimate pattern"

---

**Reporting AI-Generated Code:**

```
🤖 AI-GENERATED CODE ASSESSMENT: [Confidence]

Indicators found:
✓ Identical try-catch in 2 places (high weight)
✓ Generic names with unclear context (moderate weight)
? Over-commenting (but could be style choice)

Score: 45/100 → Moderate likelihood (40-50%)

Confidence: Medium
- Multiple indicators present
- Some could be legitimate patterns
- Recommend manual review

Note: Cannot definitively say code is AI-generated without seeing prompts.
These are heuristic patterns, not proof.
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

## 🔧 Configuration Handling

**Configuration file:** `.ai-audit-config.json` (optional, in project root)

### Detecting Configuration
Check if file exists:
```bash
# Look for .ai-audit-config.json in current directory
if [ -f ".ai-audit-config.json" ]; then
  # Use configuration
else
  # Use defaults
fi
```

### Valid Configuration Fields
```json
{
  "ignorePaths": ["string array"],           // Paths to skip
  "analyzeUnstagedOnly": "boolean",          // Only unstaged changes
  "severityThreshold": "low|medium|high",    // Minimum issue level
  "aiGeneratedThreshold": "0.0-1.0",         // AI confidence (0-1)
  "enableDetailedReport": "boolean"          // Include code snippets
}
```

### Configuration Validation Rules

**FOR EACH FIELD:**

1. **ignorePaths**
   - Type: Array of strings
   - Error: "ignorePaths must be array of strings"
   - Default: `["node_modules", "dist", "build"]`
   - Example: `["vendor", ".git", "out"]`

2. **analyzeUnstagedOnly**
   - Type: Boolean (true/false)
   - Error: "analyzeUnstagedOnly must be true or false"
   - Default: `false`
   - Invalid: `"true"` (string instead of boolean)

3. **severityThreshold**
   - Type: String (must be one of: "low", "medium", "high")
   - Error: "severityThreshold must be 'low', 'medium', or 'high'"
   - Default: `"medium"`
   - Invalid: `"warning"`, `1`, `HIGH`

4. **aiGeneratedThreshold**
   - Type: Number between 0.0 and 1.0
   - Error: "aiGeneratedThreshold must be between 0 and 1"
   - Default: `0.3`
   - Invalid: `"0.3"` (string), `1.5` (too high), `-0.1` (negative)

5. **enableDetailedReport**
   - Type: Boolean (true/false)
   - Error: "enableDetailedReport must be true or false"
   - Default: `true`
   - Invalid: `"yes"`, `1`

### Error Handling

**When configuration is invalid:**

```
ERROR: Invalid .ai-audit-config.json

Problems found:
1. severityThreshold: must be 'low', 'medium', or 'high'
   Got: "warning"
   Line: 4

2. aiGeneratedThreshold: must be between 0 and 1
   Got: 1.5
   Line: 5

SOLUTION:
- Fix the configuration file and retry
- Or delete .ai-audit-config.json to use defaults

Using defaults for now...
```

**Report error then:**
- Continue with defaults (fail gracefully)
- Show what fields were invalid
- Suggest how to fix them
- Don't crash or hang

### Default Configuration (if no file or invalid file)

```json
{
  "ignorePaths": ["node_modules", "dist", "build", ".git", ".next"],
  "analyzeUnstagedOnly": false,
  "severityThreshold": "medium",
  "aiGeneratedThreshold": 0.3,
  "enableDetailedReport": true
}
```

---

## ⚙️ Implementation Rules

**MUST DO:**
- ✓ Get uncommitted changes (git diff or git status)
- ✓ Examine actual code, not just filenames
- ✓ Report with specific file:line references
- ✓ Provide actionable recommendations
- ✓ Be honest about confidence levels
- ✓ Validate configuration file if present
- ✓ Report configuration errors clearly
- ✓ Fail gracefully (use defaults if config bad)

**MUST NOT DO:**
- ✗ Make up issues that don't exist
- ✗ Report all possible improvements (focus on actual issues)
- ✗ Ignore language-specific considerations
- ✗ Use vague descriptions ("refactor this")
- ✗ Claim 100% accuracy on AI detection (it's heuristic-based)
- ✗ Crash on invalid configuration
- ✗ Silently ignore configuration errors
- ✗ Apply invalid configuration

**BE REALISTIC:**
- Acknowledge if changes look clean
- Note if AI detection is uncertain
- Don't over-analyze minor code style issues
- Focus on real problems that affect functionality
- Report configuration problems clearly before analysis

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
