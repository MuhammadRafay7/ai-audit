# Test Case 3: Code Duplication

## Code File
`code.js`

## Known Issues
1. `validateEmail()` and `validateUserEmail()` - Identical code (lines 4-7 and 10-13)
2. `validatePassword()` and `validateNewPassword()` - Identical code (lines 16-27 and 30-41)

## What ai-audit Should Find

Should report:
- Duplicate email validation (exact same code in two functions)
- Duplicate password validation (exact same code in two functions)
- Recommend extraction to shared utilities

## Example Valid Output

```
🔄 CODE DUPLICATION DETECTED

Duplicate 1: Email Validation
  validateEmail() at line 4
  validateUserEmail() at line 10
  Type: Identical code (exact match)
  Action: Extract to shared validateEmail() function

Duplicate 2: Password Validation
  validatePassword() at line 16
  validateNewPassword() at line 30
  Type: Identical code (exact match)
  Action: Extract to shared validatePassword() function

Duplication: 15%

Quality Score: 6/10
```

## Scoring

- ✓ If both duplicates found: PASS
- ⚠ If 1 found: PARTIAL
- ✗ If neither found: FAIL
