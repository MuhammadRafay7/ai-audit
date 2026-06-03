# Test Case 1: Missing Error Handling

## Code File
`code.js`

## Known Issues
1. `fetchUserData()` - Missing error handling on await
2. `loadConfig()` - Missing catch on promise chain

## What ai-audit Should Find

Should report:
- `fetchUserData()` at line 4: Missing try-catch or error handling on `await fetch()`
- `loadConfig()` at line 9: Missing `.catch()` handler on promise chain

Should recognize these as HIGH severity (unhandled errors can crash app).

## Example Valid Output

```
❌ ERRORS FOUND (2)

code.js:4 - Missing error handling
  Problem: await fetch() without try-catch
  Severity: High
  Fix: Wrap in try-catch block

code.js:9 - Unhandled promise rejection
  Problem: .json() call without .catch()
  Severity: High
  Fix: Add .catch() handler

Quality Score: 4/10
```

## Scoring

- ✓ If both errors found: PASS
- ⚠ If 1 error found, 1 missed: PARTIAL
- ✗ If no errors found: FAIL
