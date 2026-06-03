# ai-audit Sample Outputs

Real and realistic examples of what `/ai-audit` actually produces.

## Example 1: Simple Code with Minor Issues

### Files Changed
```
src/utils.ts (34 lines modified)
```

### Actual Output

```
=== CODE QUALITY AUDIT ===

📁 FILES ANALYZED: 1 file
└── src/utils.ts (34 lines)

⚠️ BEST PRACTICE ISSUES (1)

utils.ts:8-22 - Function too long
  Problem: formatDate() is 15 lines, reasonable but could be split
  Suggestion: Consider extracting date validation into separate function

📈 QUALITY METRICS
├── Overall Score: 7/10
├── Critical Issues: 0
├── Warnings: 1
├── AI-Generated Likelihood: 20%
└── Duplication: None detected

💡 ASSESSMENT
Code is clean and well-structured. Minor improvements possible but no blocking issues.
Ready to commit.
```

**What worked:** Clear analysis, reasonable recommendations, honest about low issues.

---

## Example 2: AI-Generated Code (Realistic)

### Files Changed
```
src/database/queries.js (89 lines)
src/api/handlers.js (67 lines)
```

### Actual Output

```
=== CODE QUALITY AUDIT ===

📁 FILES ANALYZED: 2 files
├── src/database/queries.js (89 lines)
└── src/api/handlers.js (67 lines)

🤖 AI-GENERATED CODE PATTERNS DETECTED

Indicators found:
- Generic variable names: 4 instances
  * queries.js:12 - const result = db.query(sql)
  * queries.js:34 - const data = rows.map(item => item)
  * handlers.js:15 - const response = await fetch(url)
  * handlers.js:42 - const obj = JSON.parse(body)

- Boilerplate error handling: 2 instances
  * queries.js:15 - try/catch with generic error logging
  * handlers.js:18 - identical try/catch structure

- Over-commenting: 3 instances
  * "Query the database and return results" (on simple query)
  * "Loop through items" (obvious from code)

AI-GENERATED LIKELIHOOD: Moderate (40-50%)
Confidence: Medium - Multiple indicators present but code is functional

❌ ERRORS FOUND (1)

handlers.js:45 - Missing null check
  Problem: result.user.id accessed without null check on result.user
  Impact: Will crash if user is undefined
  Fix: Add guard: if (!result?.user?.id) return error;

📈 QUALITY METRICS
├── Overall Score: 5.5/10
├── Critical Issues: 1
├── Warnings: 3
├── AI-Generated Likelihood: 40%
└── Duplication: 10%

💡 TOP PRIORITIES
1. Fix null reference in handlers.js:45 (CRITICAL)
2. Rename generic variables (readability)
3. Extract duplicate error handling pattern

✨ ASSESSMENT
Code shows signs of AI generation but is mostly functional. Main concern is missing
error handling that could cause runtime crashes. Recommend: fix the null check,
then review variable names and extracted common patterns.
```

**What's realistic here:**
- Honest "moderate" confidence, not 100% certainty
- Found both real error and code quality issues
- Generic names detected but not over-reported
- Acknowledged that code is "mostly functional"

---

## Example 3: Refactored Code (Good Quality)

### Output

```
=== CODE QUALITY AUDIT ===

📁 FILES ANALYZED: 5 files
├── src/components/Button.tsx (42 lines)
├── src/hooks/useButton.ts (38 lines)
├── src/styles/button.css (21 lines)
├── src/utils/buttonUtils.ts (19 lines)
└── tests/button.test.tsx (67 lines)

✅ NO CRITICAL ISSUES

📋 OBSERVATIONS

✨ What's Good:
- Clear separation of concerns (component, hook, styles, utils)
- Descriptive variable names throughout
- Good test coverage (test file exists)
- Consistent naming conventions (camelCase)

⚠️ Minor Suggestions:
- Button.tsx:12 - Could add JSDoc comments to exported component
- useButton.ts:5 - Type annotations are good, parameter docs would help

🔄 DUPLICATION CHECK: None detected

📈 QUALITY METRICS
├── Overall Score: 8/10
├── Critical Issues: 0
├── Warnings: 0
├── AI-Generated Likelihood: 15%
└── Duplication: 0%

💡 ASSESSMENT
Well-structured refactor. Code is clean, organized, and maintainable. Minor
documentation improvements would help onboarding, but no blocking issues.
Safe to commit and deploy.
```

**Realistic elements:**
- Acknowledges what's good (not just problems)
- Suggestions are gentle, not prescriptive
- Low AI generation likelihood (good hand-written code)
- Clear "safe to commit" assessment

---

## Example 4: Large Feature with Mixed Quality

### Output

```
=== CODE QUALITY AUDIT ===

📁 FILES ANALYZED: 12 files
├── src/auth/Login.tsx (124 lines)
├── src/auth/useAuth.ts (87 lines)
├── src/api/authService.ts (156 lines)
├── src/utils/validators.ts (92 lines)
├── [8 more files...]

❌ CRITICAL ISSUES (2)

authService.ts:42 - Unhandled promise rejection
  Problem: fetch() call without .catch() or try-catch
  Impact: Could crash app if network fails
  Fix: Wrap in try-catch or add .catch() handler

Login.tsx:67 - Hardcoded API endpoint
  Problem: API URL hardcoded in component: "https://api.example.com/..."
  Impact: Can't change environment easily, security concern
  Fix: Use environment variable: process.env.REACT_APP_API_URL

⚠️ CODE QUALITY ISSUES (4)

useAuth.ts:15-52 - Long function (38 lines)
  Suggestion: Split into separate hooks (useAuthState, useAuthCallbacks)

validators.ts:8, validators.ts:31, authService.ts:89 - Email validation repeated
  Files: validators.ts (2x), authService.ts (1x)
  Action: Create single validateEmail() in validators, use everywhere

Login.tsx:5 - Generic import name
  Problem: import * as auth from './auth' (unclear what auth is)
  Better: import { useAuth } from './auth'

Login.tsx - Missing error boundaries
  Problem: Component could crash, not caught
  Suggestion: Wrap with ErrorBoundary component

🤖 AI-GENERATED PATTERNS: Moderate (35%)
  - Generic names in several files (data, result, response)
  - Boilerplate try-catch patterns
  - Some obvious comments ("get user data")

🔄 CODE DUPLICATION: 12%
  - Email validation function duplicated
  - Similar error handling patterns (3 instances)
  - Button styling patterns (CSS)

📈 QUALITY METRICS
├── Overall Score: 5.5/10
├── Critical Issues: 2
├── High Priority: 4
├── Medium Priority: 3
├── AI-Generated Likelihood: 35%
└── Duplication: 12%

💡 TOP PRIORITIES
1. [BLOCKING] Fix unhandled promise rejection in authService.ts:42
2. [BLOCKING] Move API URL to environment variable (security)
3. [IMPORTANT] Extract duplicate email validation
4. [IMPORTANT] Refactor long useAuth function
5. [NICE-TO-HAVE] Add error boundaries to Login component

✨ ASSESSMENT
Feature has good structure overall but contains 2 blocking issues that must be
fixed before merge:
- Network error handling (would crash app)
- Hardcoded API endpoint (security & deployment issue)

Also recommend: extract validation logic, refactor long hook, improve error handling.

With fixes, this would be production-ready.
```

**Realistic for real code:**
- Found actual problems (unhandled promise, hardcoded URL)
- Prioritized what's blocking vs. nice-to-have
- Acknowledged that code has good structure despite issues
- Clear path forward

---

## Example 5: What ai-audit Can't Do

These are cases where output might be less reliable:

### Language-Specific Issues
```
Python file with type hints - may not catch type mismatches reliably
Java with complex generics - may miss subtle type issues
Rust with borrow checker rules - unlikely to catch ownership issues
```

### Architectural Issues
```
- Global state management patterns
- Dependency injection problems
- Microservices communication issues
- Database schema inconsistencies
```

### Performance Issues
```
- N+1 query problems (requires database knowledge)
- Algorithm complexity (O(n²) vs O(n log n))
- Memory leaks (requires memory profiling)
```

### Business Logic
```
- Incorrect business rules implementation
- Edge cases in specific domain logic
- Requirements compliance issues
```

---

## Key Takeaways

### ✅ ai-audit IS Good For:
- Finding obvious bugs and errors
- Detecting AI-generated patterns (with moderate accuracy)
- Catching code quality issues (naming, length, duplication)
- Providing pre-commit sanity checks
- Learning about best practices

### ⚠️ ai-audit IS NOT Good For:
- Catching subtle architectural problems
- Finding language-specific edge cases
- Performance optimization
- Security audits (only catches obvious issues)
- Business logic validation

### 🎯 Best Used As:
- **First pass review** before human code review
- **Learning tool** to understand patterns
- **Pre-commit check** to catch obvious issues
- **Consistency tool** to maintain standards
- **Not a replacement** for thorough code review

---

**Remember:** ai-audit is a helpful assistant tool, not a complete code quality solution. Combine it with human review, tests, and linting tools for best results.
