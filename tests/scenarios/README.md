# Test Scenarios

Code samples with known issues for validating ai-audit.

## How to Test

### 1. Pick a scenario
```
01-missing-error-handling/
02-null-reference/
03-code-duplication/
```

### 2. Create a git repo
```bash
mkdir test-repo
cd test-repo
git init
cp ../scenarios/01-missing-error-handling/code.js .
git add code.js
```

### 3. Run ai-audit
```bash
/ai-audit
```

### 4. Compare results
```bash
# Read what you got
# Compare to EXPECTED.md in the scenario folder
# Record if it matched
```

### 5. Report findings
See `/VALIDATION_TEMPLATE.md` for how to report results.

## Test Scenarios

### 01: Missing Error Handling
- **File:** `code.js`
- **Known issues:** 2 unhandled async operations
- **Difficulty:** Easy - obvious errors
- **Expected accuracy:** High (should catch both)

### 02: Null References
- **File:** `code.ts`
- **Known issues:** 2 missing null checks
- **Difficulty:** Medium - requires understanding types
- **Expected accuracy:** Medium (might catch 1/2)

### 03: Code Duplication
- **File:** `code.js`
- **Known issues:** 2 sets of identical code
- **Difficulty:** Easy - exact duplication
- **Expected accuracy:** High (should catch both)

## Adding More Scenarios

To add a test scenario:

1. Create folder: `NN-description/`
2. Add `code.[js|ts|py]` with known issues
3. Add `EXPECTED.md` with:
   - Description of known issues
   - What ai-audit should find
   - Example of valid output
   - Scoring criteria (PASS/PARTIAL/FAIL)
4. Update this README with scenario description

## Quick Test

Run all scenarios quickly:

```bash
for scenario in */; do
  echo "Testing: $scenario"
  cd "$scenario"
  
  mkdir -p /tmp/test-$scenario
  cd /tmp/test-$scenario
  git init
  cp /path/to/ai-audit/tests/scenarios/$scenario/code.* .
  git add code.*
  /ai-audit > actual.txt 2>&1
  
  echo "Compare actual.txt to EXPECTED.md"
  diff /path/to/ai-audit/tests/scenarios/$scenario/EXPECTED.md actual.txt
  
  cd ..
done
```

## What This Validates

- Error detection accuracy
- Duplication detection
- Code quality analysis
- Severity assignment
- Quality scoring

## What This Doesn't Validate

- AI-generation pattern detection (no synthetic AI code here)
- Best practices checking (no framework code)
- Large project analysis (small code samples)
- Language variety (mostly JS/TS)

---

**Goal:** Use these scenarios to establish baseline accuracy of ai-audit.
Report results to `/VALIDATION.md`
