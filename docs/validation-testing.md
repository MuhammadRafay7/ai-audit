# Testing & Validation Guide

How to validate that `/ai-audit` works accurately in practice.

## Why Testing Matters

The skill is only as good as:
1. Claude's code analysis ability
2. SKILL.md instructions quality  
3. Real-world accuracy on edge cases

This guide helps verify performance.

## Test Categories

### 1. Accuracy Testing

Create test cases with known issues and verify detection rate.

#### Test Suite: Known Errors

```bash
mkdir -p test-cases/should-detect
cd test-cases/should-detect
```

**missing-error-handling.js**
```javascript
async function fetchUser(id) {
  const response = await fetch(`/api/users/${id}`);
  const data = response.json();  // ERROR: no await, no error handling
  return data;
}
```
**Expected:** CRITICAL - Missing error handling, missing await

---

**null-reference.ts**
```typescript
function getUsername(user: User) {
  return user.profile.name;  // ERROR: profile could be null
}
```
**Expected:** HIGH - Missing null check

---

**unhandled-rejection.js**
```javascript
fetch('/api/data').then(r => r.json());  // ERROR: no catch
```
**Expected:** HIGH - Unhandled promise rejection

---

#### Test Suite: Code Quality

**long-function.js** (>50 lines)
```javascript
function processOrder(order) {
  // ... 75 lines of mixed logic ...
}
```
**Expected:** MEDIUM - Function too long

---

**duplicate-validation.js**
```javascript
// File has email validation in 2 places
function validateEmail1(email) {
  return /^[^@]+@[^@]+\.[^@]+$/.test(email);
}

// ... other code ...

function validateEmail2(email) {
  return /^[^@]+@[^@]+\.[^@]+$/.test(email);
}
```
**Expected:** MEDIUM - Duplicate validation logic

---

#### Test Suite: AI-Generated Patterns

**clearly-ai-generated.js** (multiple strong signals)
```javascript
// Over-commenting + generic names + boilerplate
async function getData() {
  try {
    const data = await api.call();
    const result = transform(data);
    return result;
  } catch (error) {
    console.log(error);
  }
}

async function getMore() {
  try {
    const data = await api.call();
    const result = transform(data);
    return result;
  } catch (error) {
    console.log(error);
  }
}
```
**Expected:** HIGH (70-90%) - Identical boilerplate repeated exactly

---

**legitimate-generic-names.js** (should NOT flag)
```javascript
async function processRequest(request) {
  const data = request.body;  // Generic but clear: request body
  const result = validate(data);  // Generic but clear: validation result
  return result;
}
```
**Expected:** LOW (0-30%) - Generic names but context is clear, not boilerplate

---

### 2. False Positive Testing

Code that SHOULD NOT be flagged as problematic:

**framework-boilerplate.ts** (Django/React patterns)
```typescript
// Standard React pattern - should NOT be flagged as AI-generated
export const MyComponent: React.FC<Props> = ({ data }) => {
  const [state, setState] = useState(null);
  
  useEffect(() => {
    const result = process(data);
    setState(result);
  }, [data]);
  
  return <div>{state}</div>;
};
```
**Expected:** LOW - Recognized as framework pattern, not AI-generated

---

**intentional-generic-names.py** (legitimate context)
```python
# Legitimate generic names in appropriate contexts
items = load_items()
for item in items:
    result = process(item)
    yield result
```
**Expected:** LOW - Generic names but pattern is clear and idiomatic

---

### 3. False Negative Testing

Real issues that SHOULD be caught:

**subtle-logic-error.js**
```javascript
function isValidAge(age) {
  if (age > 0 || age <= 150) {  // ERROR: || should be &&
    return true;
  }
  return false;
}
```
**Expected:** MEDIUM - Logic error detected

---

## Running Validation

### Manual Testing Process

```bash
# 1. Create test directory
mkdir -p test-cases

# 2. Copy test files into git repo
# Make sure git is initialized
git init

# 3. Make test file uncommitted
echo "// test" > test-case.js
git add test-case.js

# 4. Run ai-audit
/ai-audit

# 5. Compare output vs expected
# Document any misses or false positives
```

### Automated Validation Script

Create `scripts/validate.sh`:

```bash
#!/bin/bash

# Validation script for ai-audit skill

PASS=0
FAIL=0
TOTAL=0

test_case() {
  local name=$1
  local file=$2
  local expected=$3
  
  echo "Testing: $name"
  
  # Run skill and capture output
  output=$(/ai-audit 2>&1)
  
  if echo "$output" | grep -q "$expected"; then
    echo "  ✅ PASS"
    ((PASS++))
  else
    echo "  ❌ FAIL - Expected to find: $expected"
    ((FAIL++))
  fi
  
  ((TOTAL++))
}

# Run test cases
test_case "Missing error handling" "missing-error-handling.js" "error handling"
test_case "Null reference" "null-reference.ts" "null"
test_case "Long function" "long-function.js" "too long"
test_case "AI boilerplate" "clearly-ai-generated.js" "identical"

# Report
echo ""
echo "Results: $PASS/$TOTAL passed"
if [ $FAIL -gt 0 ]; then
  echo "Failed: $FAIL test cases"
  exit 1
fi
```

## Accuracy Metrics

### Scoring Results

| Metric | Goal | How to Measure |
|--------|------|----------------|
| **Error Detection Rate** | >80% | # detected / # actual errors |
| **False Positive Rate** | <10% | # false alerts / # total alerts |
| **AI-Gen Accuracy** | >70% | # correctly identified / # AI samples |
| **False Negative Rate** | <20% | # missed / # actual issues |

### Example Scoring

```
Test Suite Results:
==================

Error Detection: 16/20 issues found = 80% ✅
False Positives: 2/18 alerts = 11% ⚠️ (aim for <10%)
AI-Generation Detection: 7/10 samples = 70% ✅
False Negatives: 4/20 issues = 20% (at limit)

Overall: Meets validation thresholds
```

## Edge Cases to Test

### Language-Specific

```python
# Python: Should understand indentation-based structure
def process():
    if True:
        pass  # Should NOT flag as always-true error
```

```typescript
// TypeScript: Should understand generics
const items: Array<T> = [];  // Generic T, not AI-generated data name
```

```go
// Go: Should understand idiomatic error handling
if err != nil {
    return err
}
```

### Framework-Specific

```javascript
// Express: Should recognize middleware pattern
app.use((req, res, next) => {
  // Not boilerplate - middleware pattern
});
```

```python
# Django: Should recognize serializer pattern
class UserSerializer(Serializer):
    def create(self, validated_data):
        return User.objects.create(**validated_data)
```

### Complex Code Patterns

```javascript
// Higher-order function (not boilerplate)
const withLogging = (fn) => {
  return (...args) => {
    console.log(args);
    return fn(...args);
  };
};
```

## Continuous Validation

### Setup for Ongoing Testing

```bash
# Create test harness
mkdir -p test-results

# Run weekly validation
# Compare results to baseline
# Track improvement over time
```

### Metrics to Track

```json
{
  "date": "2026-06-10",
  "error_detection_rate": 0.82,
  "false_positive_rate": 0.09,
  "ai_generation_accuracy": 0.71,
  "total_test_cases": 50,
  "notes": "Improved duplicate detection, slight increase in false positives on generic names"
}
```

## Known Limitations to Document

### Unavoidable False Positives

1. **Framework boilerplate** — Hard to distinguish from AI code
2. **Legitimate generic names** — Can't know intent without context
3. **Common patterns** — Multiple developers write similar code
4. **Idiomatic code** — Language conventions can look like boilerplate

### Impossible to Detect

1. **Logic errors** in complex algorithms
2. **Architectural problems** (without system design knowledge)
3. **Performance issues** (requires profiling)
4. **Business logic correctness** (requires domain knowledge)

## When to Update Heuristics

Monitor for patterns:

- **If error detection rate drops below 75%:** SKILL.md needs improvement
- **If false positive rate exceeds 15%:** Heuristics are too aggressive
- **If same issue repeatedly missed:** Add specific pattern to SKILL.md
- **If specific false positive recurring:** Add context check to reduce it

## Integration with CI/CD

Add to pre-commit or CI pipeline:

```bash
#!/bin/bash
# .git/hooks/pre-commit

/ai-audit > /tmp/audit.txt

# Fail if critical issues found
if grep -q "CRITICAL" /tmp/audit.txt; then
  cat /tmp/audit.txt
  exit 1
fi
```

## Validation Checklist

Before releasing skill:

- [ ] Error detection: >75% accuracy
- [ ] False positives: <15% of alerts
- [ ] AI-detection: >65% accuracy on known samples
- [ ] At least 30 test cases passed
- [ ] Edge cases documented
- [ ] Framework patterns recognized
- [ ] No crashes on malformed input
- [ ] Clear output format in all cases
- [ ] Confidence levels reported honestly
- [ ] Limitations documented

## Continuous Improvement

```
Month 1: Baseline validation (establish metrics)
Month 2: Refine heuristics based on false positives
Month 3: Add language-specific rules
Month 4: Test on real projects, gather feedback
Month 5-6: Iterate on most common issues

Target: Reach 85% error detection, <10% false positives by Month 6
```

---

**Version:** 1.0.0  
**Last Updated:** 2026-06-03  
**Purpose:** Ensure ai-audit meets quality standards before widespread use
