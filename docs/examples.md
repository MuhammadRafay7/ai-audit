# ai-audit Examples

Real-world examples showing how to use the `/ai-audit` skill effectively.

## Example 1: Catching a Bug Before Commit

### Scenario
You've just finished implementing a user authentication feature.

### Files Changed
- `src/auth.ts` (new feature)
- `src/utils/validation.ts` (modified)
- `tests/auth.test.ts` (new tests)

### Running the Skill

```bash
git add .
/ai-audit
```

### Output

```
=== Code Quality Audit ===

Files Changed: 3
Quality Score: 5.5/10

❌ CRITICAL ISSUES (1)
auth.ts:42 - Missing error handling in validateToken()
  - Token might be null but no try-catch
  - User could see unhandled exception
  - Fix: Wrap in try-catch block

⚠️  AI-GENERATED PATTERNS (High)
- Generic variable naming (data, result, token)
- Over-commenting on obvious code
- Boilerplate validation patterns

💡 RECOMMENDATIONS
1. [HIGH] Add error handling to validateToken()
2. [MEDIUM] Rename generic variables
3. [LOW] Remove redundant comments
```

### Action Taken

```bash
# Fix the error handling
# Edit auth.ts to add try-catch

/ai-audit  # Re-run to verify

# If all good:
git commit -m "feat: Add user authentication"
```

---

## Example 2: Improving AI-Generated Code

### Scenario
You used Claude to generate database query code.

### Files Changed
- `src/db/queries.js` (AI-generated)

### Running the Skill

```bash
/ai-audit
```

### Output

```
=== Code Quality Audit ===

Files Changed: 1
AI-Generated Likelihood: 78% 🤖

⚠️  AI-GENERATED INDICATORS (High)
├── Generic variable names
│   - Line 5: const data = result
│   - Line 12: const item = rows[0]
│
├── Boilerplate patterns
│   - Try-catch blocks copied 3x with same structure
│
└── Over-commenting
    - Each function has verbose comments explaining obvious code

💡 RECOMMENDATIONS
1. Rename variables: data→userData, item→userRecord
2. Extract repeated try-catch into helper function
3. Remove obvious comments
```

### Improvements Made

```javascript
// BEFORE (AI-Generated)
const data = result;
try {
  // Query the database
  const item = db.query(...);
  return item;
} catch (error) {
  // Handle error
  console.log(error);
}

// AFTER (Improved)
const userData = result;
async function queryDatabase(query) {
  return db.query(query);
}

try {
  const userRecord = await queryDatabase(...);
  return userRecord;
} catch (error) {
  logger.error('Database query failed:', error);
}
```

### Verify Fix

```bash
/ai-audit  # Run again
```

Output shows improved scores and removed AI-generation indicators.

---

## Example 3: Detecting Code Duplication

### Scenario
You notice validation logic appearing multiple times.

### Files Changed
- `src/auth.ts` (login validation)
- `src/api/user.ts` (profile validation)
- `src/forms/registration.ts` (registration validation)

### Running the Skill

```bash
/ai-audit
```

### Output

```
=== Code Quality Audit ===

🔄 CODE DUPLICATION (High)

Duplicate Pattern 1: Email Validation
├── auth.ts:15 - validateEmail(email)
├── api/user.ts:42 - validateEmail(email)
└── forms/registration.ts:8 - validateEmail(email)
    Action: Extract to utils/validators.js

Duplicate Pattern 2: Password Validation
├── auth.ts:25 - validatePassword(pwd)
├── forms/registration.ts:18 - validatePassword(pwd)
    Action: Extract to utils/validators.js

Duplication Index: 24%
```

### Solution

```bash
# Create utils/validators.js
cat > src/utils/validators.js << 'EOF'
export const validateEmail = (email) => {
  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
};

export const validatePassword = (pwd) => {
  return pwd.length >= 8 && /[A-Z]/.test(pwd) && /[0-9]/.test(pwd);
};
EOF

# Update all files to import from validators.js
# Then run:
/ai-audit  # Verify duplication is gone
```

---

## Example 4: Best Practices Review

### Scenario
You're reviewing a refactor in a team project.

### Files Changed
- `src/components/Button.tsx` (refactored)
- `src/hooks/useButton.ts` (new hook)

### Running the Skill

```bash
/ai-audit
```

### Output

```
=== Code Quality Audit ===

Files Changed: 2
Quality Score: 7.5/10

📋 BEST PRACTICES (3 issues)

Issue 1: Function Too Long
├── useButton.ts:12
├── Length: 95 lines
├── Recommendation: Break into smaller hooks
└── Suggested split:
    - useButtonState (state management)
    - useButtonCallbacks (event handlers)
    - useButtonStyles (styling logic)

Issue 2: Missing TypeScript Definitions
├── Button.tsx - Button component props
├── useButton.ts - Return types
└── Add: Export proper interfaces

Issue 3: No Error Boundary
├── useButton.ts might throw
├── Recommendation: Add try-catch handling
└── Example provided
```

### Improvements

```typescript
// BEFORE
export const useButton = (props) => {
  // 95 lines of mixed concerns
};

// AFTER - Broken into focused hooks
export interface ButtonState { ... }
export interface ButtonCallbacks { ... }

export const useButtonState = (initial): ButtonState => { ... }
export const useButtonCallbacks = (): ButtonCallbacks => { ... }
export const useButton = (props) => {
  return { ...useButtonState(props), ...useButtonCallbacks() }
}
```

---

## Example 5: Learning from Analysis

### Scenario
You want to understand code quality patterns.

### Files Changed
- `src/utils/string.js` (utility functions)

### Running the Skill

```bash
/ai-audit
```

### Output & Learning

```
=== Code Quality Analysis ===

This analysis shows:

✅ WHAT YOU DID WELL
- Clear function names
- Proper error handling
- Good documentation
- Consistent style

⚠️  AREAS TO IMPROVE
- Some functions over 40 lines
- Could use more tests
- Consider more validation

💡 LEARNING POINTS
- Functions should have single responsibility
- Keep functions under 50 lines when possible
- Add input validation
- Use TypeScript for type safety
```

### Action
Use these insights to write better code going forward.

---

## Example 6: Large Project Analysis

### Scenario
You're working on a complex feature affecting multiple modules.

### Files Changed (Many)
- Database schema migration
- API endpoints
- Frontend components
- Tests
- Configuration

### Running the Skill

```bash
/ai-audit
```

### Output (Summarized)

```
=== Code Quality Audit - Large Project ===

📊 SUMMARY
├── Files Changed: 24
├── Lines Changed: 2,847
├── Quality Score: 6.8/10
├── Critical Issues: 2
└── Warnings: 12

🔥 CRITICAL (Must Fix)
1. Database migration rollback not implemented
2. Missing API error validation

⚠️  IMPORTANT (Should Fix)
1. Test coverage only 45% for new code
2. Performance consideration in query
3. Duplicate logic in 3 places
4. TypeScript type gaps

📈 POSITIVE
- Good documentation
- Consistent error handling
- Well-structured tests
- Security practices followed

💡 PRIORITIZED RECOMMENDATIONS
1. Add database rollback logic [BLOCKER]
2. Validate API responses [HIGH]
3. Fix duplicate validation logic [MEDIUM]
4. Increase test coverage [MEDIUM]
5. Add TSDoc comments [LOW]
```

### Next Steps

1. Fix critical items first
2. Address important items
3. Run `/ai-audit` again to verify
4. Create PR for review

---

## Example 7: Configuration Usage

### Scenario
You want to ignore certain files and be stricter.

### Create Configuration

```bash
cat > .ai-audit-config.json << 'EOF'
{
  "ignorePaths": ["node_modules", "dist", "build", "coverage"],
  "analyzeUnstagedOnly": false,
  "severityThreshold": "low",
  "aiGeneratedThreshold": 0.25,
  "enableDetailedReport": true
}
EOF
```

### Running with Config

```bash
/ai-audit
```

The skill will:
- Skip ignored paths
- Show even low-priority issues
- Be stricter about AI-generated detection (25% threshold)
- Include detailed code snippets

---

## Example 8: Before Code Review

### Scenario
You're about to request code review from teammates.

### Workflow

```bash
# 1. Make changes
# ... write code ...

# 2. Run ai-audit
/ai-audit

# Output shows 5.2/10 - needs work

# 3. Fix issues locally
# ... improve code ...

# 4. Verify with ai-audit
/ai-audit

# Output now shows 8.1/10 - good!

# 5. Create pull request
git commit -m "Feature: ..."
git push

# 6. Teammates review with confidence
#    Knows you ran quality checks
```

---

## Quick Reference

| Goal | Command |
|------|---------|
| Check before commit | `/ai-audit` |
| Analyze staged only | `/ai-audit` (with config) |
| Find AI patterns | `/ai-audit` |
| Detect duplication | `/ai-audit` |
| Learn best practices | `/ai-audit` + read recommendations |
| Large project | `/ai-audit` (handles automatically) |

---

## Tips for Best Results

1. **Run frequently** — After each feature
2. **Fix high-priority issues** — Don't ignore critical
3. **Learn from output** — Read recommendations
4. **Extract duplicates** — Use suggestions to refactor
5. **Test improvements** — Verify fixes work
6. **Use configuration** — Customize for your project
7. **Iterate** — Run again after fixes
8. **Share with team** — Use output in code reviews

---

**Start with Example 1 and work your way through to master ai-audit!**
