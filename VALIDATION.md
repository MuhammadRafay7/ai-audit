# Validation

How to test ai-audit and report results.

## Quick Test (15 minutes)

```bash
# 1. Copy test scenario
mkdir /tmp/ai-audit-test
cd /tmp/ai-audit-test
git init
cp /path/to/ai-audit/tests/scenarios/01-missing-error-handling/code.js .
git add code.js

# 2. Run skill
/ai-audit > result.txt 2>&1

# 3. Compare to expected
cat /path/to/ai-audit/tests/scenarios/01-missing-error-handling/EXPECTED.md

# 4. Report results (see template below)
```

## Report Results

Create a GitHub issue with:

```
Test Run: [Your Name]

Environment:
- OS: [macOS/Linux/Windows]
- Claude Code version: [version]

Test Scenario:
- Scenario: 01-missing-error-handling (or 02, 03)
- Known issues: 2
- Found: [number]
- Missed: [number]
- False positives: [number]
- Accuracy: [%]

Real Code Testing (optional):
- Tested on: [project type]
- Files: [number]
- Accuracy: [%]
- Notes: [what worked/failed]

Assessment:
Would I use this regularly? [YES/MAYBE/NO]
Why: [brief reason]
```

## Test Scenarios

Three predefined tests in `tests/scenarios/`:

- **01-missing-error-handling** - 2 obvious async errors
- **02-null-reference** - 2 missing null checks
- **03-code-duplication** - 2 identical code blocks

Each has `code.*` (the buggy code) and `EXPECTED.md` (what should be found).

See `tests/scenarios/README.md` for details.

## Real Code Testing

Optional but valuable: test on your own code.

```bash
cd your-project
git add your-changes
/ai-audit
```

Compare output to known issues and false reports.

## Contribute

1. Test ai-audit on code (scenarios or your own)
2. Fill in template above
3. Create GitHub issue with results
4. Help improve by reporting what works/fails

---

**Help validate ai-audit by testing and sharing honest results.**
