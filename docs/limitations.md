# ai-audit: Limitations & Accuracy Guide

Understanding what ai-audit can and can't reliably detect.

## The Reality

ai-audit is **Claude's code analysis wrapped in a skill interface**. It's useful but has real limitations:

- ✅ Finds obvious bugs
- ✅ Detects code patterns
- ⚠️ AI-detection is heuristic-based (not 100% accurate)
- ❌ Can't understand complex architecture
- ❌ Won't catch subtle domain logic errors

## Accuracy by Category

### 🟢 HIGH ACCURACY (80-90%)

#### Error Detection
- Missing null checks: ✅ Catches most
- Unhandled promise rejections: ✅ Catches most
- Missing try-catch blocks: ✅ Usually catches
- Obvious type mismatches: ✅ Usually catches
- Resource leaks (unclosed files): ⚠️ Sometimes catches

#### Code Quality
- Function too long: ✅ Accurate
- Generic variable names: ✅ Accurate
- Missing documentation: ✅ Accurate
- Naming inconsistencies: ✅ Mostly accurate
- Code duplication: ✅ Accurate

### 🟡 MEDIUM ACCURACY (50-70%)

#### AI-Generated Code Detection
- Generic names alone: ⚠️ Could be intentional
- Boilerplate patterns: ⚠️ Could be framework code
- Over-commenting: ⚠️ Could be style choice
- **Combined signals: More reliable** (multiple indicators together)
- **Confidence levels matter** — take "moderate" with grain of salt

#### Best Practices
- Language-specific conventions: ⚠️ Depends on language
- Framework patterns: ⚠️ Depends on framework knowledge
- Performance suggestions: ⚠️ Often unreliable
- Security (basic): ⚠️ Only catches obvious issues

### 🔴 LOW ACCURACY (20-40%)

#### Complex Issues
- Architectural problems: ❌ Usually misses
- Advanced performance issues: ❌ Usually misses
- Complex type errors: ❌ Often misses (depends on language)
- Business logic correctness: ❌ Can't evaluate
- Subtle concurrency issues: ❌ Usually misses
- Database schema problems: ❌ Usually misses

#### Language-Specific
- Rust borrow checker rules: ❌ No understanding
- Python descriptor protocol: ❌ No understanding
- Java generics complexity: ❌ No understanding
- C++ template metaprogramming: ❌ No understanding

## Why These Limitations Exist

### 1. AI Model Limitations
Claude is great at understanding code semantics but:
- Can't run code to find runtime bugs
- Can't statically verify all type systems
- Can't understand all language-specific rules
- Can't profile performance

### 2. Context Limitations
ai-audit sees only:
- The current uncommitted changes
- No git history or context
- No external dependencies
- No database schemas
- No API contracts (if external)

### 3. Heuristic-Based AI Detection
Detecting "AI-generated" code uses patterns:
- Generic naming (but humans use it too)
- Boilerplate code (but frameworks use it too)
- Over-commenting (but could be style)
- **Can't know intent** — was this generated or deliberate?

## False Positives & False Negatives

### Common False Positives (Reports Issues That Don't Exist)

**Generic names in legitimate code:**
```python
# Intentional generic name (API response wrapper)
data = response.json()
result = transform(data)
```
**ai-audit says:** "Generic names found"  
**Reality:** This is fine and clear in context

**Boilerplate patterns:**
```javascript
try {
  const data = await db.query();
} catch (error) {
  logger.error(error);
}
```
**ai-audit says:** "Boilerplate error handling detected (AI-generated)"  
**Reality:** This is standard practice, not AI-generated

**Framework code:**
```python
class MyView(View):
    def get(self, request):
        return render(request, 'template.html')
```
**ai-audit says:** "Generic names, over-commenting"  
**Reality:** This is Django convention, not AI-generated

### Common False Negatives (Misses Real Issues)

**Subtle null bugs:**
```javascript
// ai-audit might miss this in complex code:
const user = getUser();
if (user) {
  return user.profile.name; // Could fail if profile is null
}
```

**Off-by-one errors:**
```python
# Semantic bug (loop excludes last item):
for i in range(len(items) - 1):  # Should be len(items)
    process(items[i])
```

**Logic errors:**
```javascript
// Condition that's always true:
if (x > 0 || x <= 0) {
  // Always executes
}
```

**Architecture issues:**
```
// Can't detect:
- Wrong service calling another service
- Circular dependencies
- Wrong data model for problem
- Inefficient database queries
```

## How to Interpret Results

### When AI-Detection Shows "High (60-90%)"
**Interpretation:**
- Multiple AI-generation indicators present
- Likely has generated code
- **But:** Could be intentional boilerplate, framework patterns, or code style
- **Action:** Review manually, don't just accept

### When It Shows "Moderate (30-60%)"
**Interpretation:**
- Some indicators present
- Could go either way
- **Action:** Examine code context, don't assume

### When It Shows "Low (0-30%)"
**Interpretation:**
- Doesn't look generated
- But could still be (no tool is perfect)
- **Action:** Trust more than higher percentages, but still verify

## Examples of Hard Cases

### Case 1: Framework Boilerplate
```python
# Is this AI-generated or Django convention?

class UserSerializer(Serializer):
    id = IntegerField()
    name = CharField()
    email = EmailField()
    
    def create(self, validated_data):
        return User.objects.create(**validated_data)
    
    def update(self, instance, validated_data):
        instance.name = validated_data.get('name', instance.name)
        instance.email = validated_data.get('email', instance.email)
        instance.save()
        return instance
```

**ai-audit might say:** "Boilerplate patterns, generic names"  
**Reality:** This is standard Django Serializer pattern  
**Why hard:** Can't distinguish convention from generation without framework knowledge

### Case 2: Intentional Generic Naming
```javascript
function processArray(items) {
    const result = [];
    for (const item of items) {
        result.push(transform(item));
    }
    return result;
}
```

**ai-audit might say:** "Generic names: item, result"  
**Reality:** `items`, `item`, `result` are appropriate here  
**Why hard:** Need semantic understanding to know when generic is OK

### Case 3: Subtle Type Error
```typescript
function getUser(id: string | number): User {
    const key = typeof id === 'string' ? id : id.toString();
    return users[key]; // Could be undefined
}
```

**ai-audit might miss:** Return type says `User` but function could return `undefined`  
**Reality:** Type system violation (TypeScript would catch though)  
**Why hard:** Complex type reasoning

## Using ai-audit Effectively

### DO
- ✅ Use as first pass before human review
- ✅ Trust obvious bug detection
- ✅ Use for learning code patterns
- ✅ Run before every commit
- ✅ Verify findings manually
- ✅ Set realistic expectations
- ✅ Combine with other tools (linters, type checkers)

### DON'T
- ❌ Trust 100% accuracy
- ❌ Accept findings blindly
- ❌ Skip human code review
- ❌ Assume AI-generation confidence is certain
- ❌ Use as only quality check
- ❌ Expect it to catch architectural issues
- ❌ Rely on it for security audits

## Combining with Other Tools

For complete coverage, combine ai-audit with:

| Tool | Purpose | Covers |
|------|---------|--------|
| **ai-audit** | Code analysis | Patterns, obvious bugs, quality |
| **ESLint** | Syntax & style | Code style, conventions |
| **TypeScript** | Type checking | Type errors, safety |
| **Pytest/Jest** | Testing | Functional correctness |
| **Bandit/SAST** | Security | Security vulnerabilities |
| **Human Review** | Everything | Context, logic, architecture |

## When ai-audit Shines

### ✨ Best Case Scenarios

1. **Junior developer code review**
   - Catches obvious mistakes
   - Suggests best practices
   - Educational feedback

2. **AI-assisted code review**
   - AI generated much of the code
   - ai-audit detects patterns
   - Quickly identifies issues

3. **Pre-commit checks**
   - Quick sanity check
   - Catch obvious bugs
   - Before human review

4. **Learning resource**
   - Understand patterns
   - See best practices
   - Improve code quality

### ❌ Where It Falls Short

1. **Complex architecture validation**
   - Microservices interactions
   - Data flow verification
   - Service dependencies

2. **Performance-critical code**
   - Algorithm analysis
   - Database query optimization
   - Memory profiling

3. **Security-critical code**
   - Full security audit
   - Vulnerability assessment
   - Penetration testing

4. **Domain-specific logic**
   - Business rule validation
   - Complex workflows
   - Edge case handling

## Conclusion

**ai-audit is a helpful tool, not a replacement for:**
- Code review (human judgment still needed)
- Type checking (use TypeScript)
- Testing (write tests)
- Security scanning (use specialized tools)
- Architecture review (require experts)

**Use it as part of a complete toolkit**, not your only quality check.

Think of it as **"a helpful reviewer who catches obvious issues but needs human oversight."**

---

**Version:** 1.0.0  
**Last Updated:** 2026-06-03
