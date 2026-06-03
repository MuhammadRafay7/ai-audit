# Validation Protocol

Step-by-step guide for testing ai-audit and reporting results.

## Quick Start (15 minutes)

### 1. Setup
```bash
# Ensure Claude Code is installed
# Copy ai-audit to ~/.claude/skills/ai-audit
# Clone this repo

cd ai-audit/
cd tests/scenarios/01-missing-error-handling
```

### 2. Create Test Environment
```bash
mkdir /tmp/ai-audit-test-1
cd /tmp/ai-audit-test-1
git init
cp /path/to/ai-audit/tests/scenarios/01-missing-error-handling/code.js .
git add code.js
```

### 3. Run ai-audit
```bash
/ai-audit
```

### 4. Record Output
```bash
# Copy the output to a file
/ai-audit > result.txt 2>&1

# Now compare to expected output
cat /path/to/ai-audit/tests/scenarios/01-missing-error-handling/EXPECTED.md
```

### 5. Assess Results
**For each known issue:**
- ✓ FOUND: ai-audit reported it
- ✗ MISSED: ai-audit didn't report it
- ? UNCLEAR: ai-audit reported something but unclear if correct
- ✗ FALSE: ai-audit reported something that's not actually an issue

## Detailed Testing

### Per-Scenario Test

```bash
# For each test scenario:

1. Create git repo
   mkdir /tmp/test-scenario-X
   cd /tmp/test-scenario-X
   git init

2. Copy code
   cp /path/to/scenarios/0X-name/code.* .
   git add code.*

3. Run skill
   /ai-audit > actual-output.txt 2>&1

4. Read expected output
   cat /path/to/scenarios/0X-name/EXPECTED.md

5. Compare
   diff expected.txt actual-output.txt
   # Or manually read both files

6. Score results
   - Found X / Y known issues
   - False positives: N
   - Unclear: M
```

### Data to Collect

For each test scenario:

```
Scenario: 01-missing-error-handling
Date: YYYY-MM-DD
Time: HH:MM UTC

RESULTS:
--------
Known issues: 2
Found: [number]
Missed: [number]
False positives: [number]
Unclear: [number]

Accuracy: [found] / [known] = XX%

DETAILS:
--------
Issue 1: Line 5 - Missing error handling on fetch
  - ai-audit said: [what it reported, or "nothing"]
  - Correct: YES / NO / PARTIAL

Issue 2: Line 10 - Missing catch on promise
  - ai-audit said: [what it reported, or "nothing"]
  - Correct: YES / NO / PARTIAL

COMMENTS:
---------
[Any observations, error messages, unexpected behavior]
```

## Testing Across Projects

For comprehensive validation, test on **your own real code**:

### Real Code Testing

```bash
# Pick a project you own
cd your-real-project

# Make some intentional changes (or just use existing uncommitted work)
git add some-changes

# Run ai-audit
/ai-audit > real-world-result.txt

# Assess:
# - Did it find real issues?
# - Did it find false issues?
# - What was accurate?
# - What was wrong?
```

## Reporting Results

### Use the Template

See `/VALIDATION_TEMPLATE.md` for the format to report.

Quick version:

```markdown
## Test Run: [Your Name/Project]
- Date: YYYY-MM-DD
- Files tested: N
- Skill version: 0.1.0-alpha

### Scenario Results

| Scenario | Known Issues | Found | Missed | False | Accuracy |
|----------|------|-------|--------|--------|----------|
| 01-missing-error-handling | 2 | 2 | 0 | 0 | 100% |
| 02-null-reference | 2 | 1 | 1 | 0 | 50% |
| 03-code-duplication | 2 | 2 | 0 | 0 | 100% |

**Average Accuracy:** 83%

### Comments
[What worked well, what didn't, specific observations]

### Environment
- OS: [Windows/macOS/Linux]
- Claude Code version: [version]
- Node.js version: [version, if applicable]
```

## What to Look For

### Good Signs
- ✓ Catches obvious errors
- ✓ Finds actual code duplication
- ✓ Reports with specific line numbers
- ✓ Distinguishes severity levels
- ✓ Honest about uncertainty

### Red Flags
- ✗ Reports issues that don't exist
- ✗ Misses obvious errors
- ✗ Vague output (no line numbers)
- ✗ Confidence level not stated
- ✗ Crashes or hangs

## Submit Results

### Step 1: Create GitHub Issue
Title: `Validation Results: [Your Name] - [Date]`

### Step 2: Paste Template
Use `/VALIDATION_TEMPLATE.md` format

### Step 3: Add Details
- Exact commands you ran
- Full ai-audit output (paste it)
- Your assessment
- Environment details

### Step 4: Expected Comment

Example:
```markdown
## Validation Test: John Doe - 2026-06-10

Files tested: Test scenarios 1-3

**Results:**
- Scenario 1: 2/2 correct = 100%
- Scenario 2: 1/2 correct = 50%
- Scenario 3: 2/2 correct = 100%
- Average: 83%

**Comments:**
Error detection works well. Null reference detection missed one. 
Good accuracy overall for simple cases.

**Issues:**
- No false positives
- All findings had correct line numbers
- Quality scores seemed reasonable
```

## Continuous Validation

Track results over time:

```bash
# Create results file
touch VALIDATION_RESULTS.csv

# Add header
echo "Date,Scenario,Known,Found,Accuracy,Environment" >> VALIDATION_RESULTS.csv

# Add results after each test
echo "2026-06-10,01,2,2,100%,Linux" >> VALIDATION_RESULTS.csv
```

## Questions?

If output is unclear:
1. Check `/EXPECTED.md` again
2. Compare output to what it should find
3. Open an issue with:
   - The code sample
   - What ai-audit said
   - What you expected
   - Your confusion

## Next Steps After Testing

1. **Report results** - Even if accuracy is low, report it
2. **Discuss findings** - Comment on issues, ask questions
3. **Help improve** - Suggest heuristic improvements
4. **Aggregate data** - Help collect results from others

---

**Thank you for helping validate ai-audit.**

Honest feedback — good or bad — helps make this better.
