# Validation Results Template

Copy this template and fill it out when you test ai-audit.

## Header

```markdown
## Validation Test: [Your Name/Username]

- Date: YYYY-MM-DD
- Skill version: 0.1.0-alpha
- Time spent: [estimate, e.g., 30 minutes]
```

## Environment

```markdown
### Environment
- OS: [Windows / macOS / Linux]
- Claude Code version: [version number]
- Node.js version: [if applicable]
- Git version: [version number]
```

## Test Scenario Results

Use this table for the predefined test scenarios:

```markdown
### Test Scenarios (from /tests/scenarios/)

| # | Scenario | Known Issues | Found | Missed | False Positives | Accuracy | Notes |
|---|----------|------|-------|--------|--------|----------|-------|
| 1 | missing-error-handling | 2 | ? | ? | ? | ?% | |
| 2 | null-reference | 2 | ? | ? | ? | ?% | |
| 3 | code-duplication | 2 | ? | ? | ? | ?% | |

**Average Accuracy:** ?%
```

Fill in the `?` with actual numbers.

## Real Code Testing (Optional)

If you tested on real code, report that too:

```markdown
### Real Code Testing

**Project:** [name/type]
**Files changed:** [number]
**Known issues:** [if you know them, or "unknown"]

**Results:**
- Found: [number] issues
- Seemed accurate: [Y/N/MOSTLY]
- False positives: [Y/N/MAYBE]

**Quality Score:** [ai-audit's reported score, if shown]

**Example finding:**
[Paste one thing ai-audit reported that seemed good or bad]
```

## Detailed Feedback

For each test that didn't go 100%:

```markdown
### Scenario 2: null-reference (Partial success)

**Known Issues:**
1. Line 5: Missing null check on user.profile
2. Line 9: Missing null check on company

**What ai-audit Found:**
[Paste the actual output here]

**Assessment:**
- Issue 1: ✓ FOUND correctly
- Issue 2: ✗ MISSED

**Why it might have missed Issue 2:**
[Your guess on why the skill failed here]
```

## Overall Assessment

```markdown
### Summary

**What Worked Well:**
- [Example: Error handling detection was accurate]
- [Example: Line numbers were correct]
- [Example: Severity levels made sense]

**What Didn't Work:**
- [Example: Missed null reference on optional properties]
- [Example: False positive on generic names in loops]
- [Example: Couldn't understand TypeScript types]

**Recommendations:**
- [What could improve detection]
- [What heuristics seemed weak]
- [What would help]

**Overall Confidence:**
Would I use this regularly? [YES / MAYBE / NO]

Why: [Brief explanation]
```

## Issues Encountered

If something went wrong:

```markdown
### Issues

**Error message:**
```
[Paste any error output here]
```

**What you were doing:**
[Steps that caused the error]

**Expected behavior:**
[What should have happened]

**Actual behavior:**
[What happened instead]
```

## Additional Context

```markdown
### Additional Info
[Anything else relevant - code samples, links, observations]
```

---

## Example Completed Form

```markdown
## Validation Test: Jane Smith

- Date: 2026-06-15
- Skill version: 0.1.0-alpha
- Time spent: 45 minutes

### Environment
- OS: macOS
- Claude Code version: 1.5.2
- Node.js version: 18.16.0
- Git version: 2.41.0

### Test Scenarios

| # | Scenario | Known Issues | Found | Missed | False Positives | Accuracy | Notes |
|---|----------|------|-------|--------|--------|----------|-------|
| 1 | missing-error-handling | 2 | 2 | 0 | 0 | 100% | Perfect |
| 2 | null-reference | 2 | 1 | 1 | 0 | 50% | Missed optional field |
| 3 | code-duplication | 2 | 2 | 0 | 1 | 67% | Also flagged 1 false duplicate |

**Average Accuracy:** 72%

### Real Code Testing

**Project:** my-web-api (Node.js/Express)
**Files changed:** 3
**Known issues:** ~2 from my review

**Results:**
- Found: 3 issues (includes 1 legitimate bug I wrote)
- Seemed accurate: MOSTLY
- False positives: 1 (flagged common pattern as AI code)

**Quality Score:** 7/10

### Summary

**What Worked Well:**
- Error detection on async/await
- Finding duplicate validation code
- Line numbers were accurate
- Severity levels made sense

**What Didn't Work:**
- Null reference detection on optional TypeScript properties
- 1 false positive on common generic variable name in loop
- Didn't understand that Express middleware pattern was legitimate

**Recommendations:**
- Improve TypeScript type understanding
- Reduce false positives on generic names in obvious contexts
- Add framework pattern recognition

**Overall Confidence:** MAYBE
I'd use it as a first pass before code review, but wouldn't trust AI-pattern detection yet.

### Issues Encountered

None. No errors or crashes.

### Additional Info

The skill seems solid for catching obvious errors. Main limitation is false positives on AI-detection and missing some subtle null checks. Would be more useful if it understood TypeScript types better.
```

---

## How to Submit

1. **Copy this template** (entire markdown block)
2. **Fill it out** with your test results
3. **Create GitHub issue** titled: `Validation Results: [Your Name] - [Date]`
4. **Paste** the completed template into the issue
5. **Submit**

Thank you for helping validate ai-audit!
