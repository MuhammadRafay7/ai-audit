# Test Case 2: Null Reference

## Code File
`code.ts`

## Known Issues
1. Line 5: `user.profile.name` - user could be null, profile could be null
2. Line 9: `company.name` - company is optional and could be null

## What ai-audit Should Find

Should report:
- Missing null check before accessing `user.profile`
- Missing null check before accessing `company.name`

## Example Valid Output

```
❌ ERRORS FOUND (2)

code.ts:5 - Missing null check
  Problem: user.profile accessed without null check
  user is possibly null, profile is possibly null
  Severity: High
  Fix: Add guard: if (user?.profile?.name) { ... }

code.ts:9 - Missing null check
  Problem: company.name accessed without null check
  company is optional (could be undefined)
  Severity: High
  Fix: Add guard: if (company?.name) { ... }

Quality Score: 3/10
```

## Scoring

- ✓ If both null issues found: PASS
- ⚠ If 1 found: PARTIAL
- ✗ If neither found: FAIL
