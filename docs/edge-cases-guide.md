# Edge Cases & Special Handling Guide

How to handle tricky scenarios that break simple rules.

## 1. Generic Names with Clear Context

### The Problem
```javascript
const data = response.json();
const result = validate(data);
```

Simple heuristic: "data" and "result" are generic → flag as AI-generated
**Reality:** Not AI-generated, names are perfectly clear in context

### The Solution
**Check context clues:**

✅ **DON'T flag if:**
- Generic name + obvious source: `const data = request.body`, `const result = api.call()`
- Generic name + clear transformation: `const result = transform(input)`
- Generic name + single use in simple function (< 20 lines)
- Generic name + idiomatic pattern: `for (const item of items)`

❌ **DO flag if:**
- Generic name + unclear purpose: `const data = complexCalculation()` (what is it?)
- Generic name + repeated 5+ times in file
- Generic name + combined with boilerplate patterns
- Generic name + over-commented

### Example Handling

```javascript
// CONTEXT = "API call" → don't flag data
const data = await fetch('/api/users').then(r => r.json());

// CONTEXT = "unclear calculation" → FLAG
const result = performManyOperations();
const data = result.map(x => x.something);
// What are result, data exactly? Unclear.
```

---

## 2. Framework Boilerplate vs AI Boilerplate

### The Problem
```python
# Django serializer pattern (legitimate)
class UserSerializer(Serializer):
    def create(self, validated_data):
        return User.objects.create(**validated_data)

# AI-generated boilerplate (not legitimate)
def process():
    try:
        result = operation()
        return result
    except Exception as e:
        print(e)
```

Both have repetitive patterns, but one is framework convention, the other is AI.

### The Solution
**Check for framework signatures:**

✅ **Framework patterns (DON'T flag):**
- Django: `Serializer`, `ModelForm`, `View` classes
- React: `useState`, `useEffect`, `props` patterns
- Express: `app.use()`, middleware patterns
- Spring: `@Controller`, `@Service` annotations
- Rails: `before_action`, `has_many` patterns

❌ **True boilerplate (DO flag):**
- Identical custom functions repeated
- Try-catch blocks without framework reason
- Generic wrapper functions
- Placeholder code ("TODO:", "FIXME:")

### Example Handling

```python
# DON'T flag - Django pattern
class ProductSerializer(Serializer):
    name = CharField()
    price = DecimalField()
    def create(self, validated_data):
        return Product.objects.create(**validated_data)

# DO flag - Non-framework boilerplate
def handle_request():
    try:
        data = request.data
        return process(data)
    except Exception as e:
        log.error(e)

def handle_file():
    try:
        file = request.file
        return process(file)
    except Exception as e:
        log.error(e)  # Identical structure, not framework
```

---

## 3. Legitimate Code Comments

### The Problem
```javascript
// Over-commenting is an AI indicator
// But some projects actually prefer explicit comments

// Get user by ID
const user = getUser(id);

// Check if exists
if (!user) {
  return error;
}
```

Is this AI-generated or just verbose commenting style?

### The Solution
**Distinguish "explaining what" from "explaining why":**

✅ **Legitimate comments (DON'T flag):**
```javascript
// User ID is from JWT token, already validated
const user = getUserFromCache(id);

// Skip DB if cached to avoid performance hit
if (!user) {
  user = await db.query();
}
```
Comments explain *why*, add information.

❌ **Restating comments (DO flag):**
```javascript
// Get the user
const user = getUser();

// Increment counter
counter++;

// Check if null
if (user == null) { ... }
```
Comments just restate obvious code.

### Example Handling

**If comment-to-code ratio > 1:2 AND comments just restate code:**
- High AI likelihood

**If comments explain business logic OR optimization reasons:**
- Not AI-generated (legitimate comments)

---

## 4. Vendor/Generated Code

### The Problem
```javascript
// Is this boilerplate or did someone generate it?

// Auto-generated from API spec
// DO NOT EDIT

class APIClient {
  getUsers() { ... }
  createUser() { ... }
  updateUser() { ... }
}
```

Should we flag auto-generated code as "AI-generated"?

### The Solution

✅ **DON'T flag if header says "auto-generated":**
```javascript
// This file was auto-generated from schema.json
// DO NOT EDIT MANUALLY
```

✅ **DON'T flag vendor code:**
```javascript
// From: moment.js v2.x
// Licensed: MIT
```

❌ **DO flag if:**
- No header indicating auto-generation
- Mixed with hand-written code
- Unclear if intentionally generated

---

## 5. Different Code Styles Are Valid

### The Problem

Some developers prefer:
```javascript
// Style A: Short, concise
const getConfig = () => ({
  host: process.env.HOST,
  port: process.env.PORT
});

// Style B: Verbose, explicit
function getConfiguration() {
  const host = process.env.HOST;
  const port = process.env.PORT;
  return {
    host: host,
    port: port
  };
}
```

Don't flag Style B as "AI-generated" just because it's verbose.

### The Solution

✅ **Check consistency:** Is the style consistent throughout the file?
- Consistent verbose style = legitimate preference
- Inconsistent (some verbose, some terse) = might be mixed (AI + human)

❌ **Don't flag verbose code if:**
- Consistently verbose throughout
- Matches team style guide
- Has legitimate reasons (clarity, debugging, etc.)

---

## 6. Short Functions with Generic Names

### The Problem
```javascript
function process(item) {
  const data = item.value;
  const result = transform(data);
  return result;
}
```

Generic names in a short, simple function.  
Could be AI or could be intentional simplicity.

### The Solution

**For short functions (< 20 lines):**
- Generic names are less concerning (context is visible)
- Need multiple other indicators to flag as AI

**For long functions (> 50 lines):**
- Generic names are more concerning (can't see all context)
- More likely to be AI-generated

---

## 7. Error Handling Patterns

### The Problem
```javascript
// Same try-catch in multiple places
try {
  const result = await operation1();
} catch (error) {
  log.error(error);
}

try {
  const result = await operation2();
} catch (error) {
  log.error(error);
}
```

Identical pattern could be:
- Good practice (consistent error handling)
- AI-generated code (repeated template)

### The Solution

**Check if pattern serves a purpose:**

✅ **Good practice (DON'T flag):**
- Consistent error handling strategy
- Different operations, same pattern
- Pattern is team standard

❌ **Likely AI-generated (DO flag):**
- Identical code blocks (variable names included)
- Multiple instances
- No clear reason for duplication
- Could be extracted into helper function

**Example distinction:**

```javascript
// GOOD: Same pattern, different operations
try {
  const user = await db.fetchUser(id);
  return user;
} catch (error) {
  logger.error(`User fetch failed: ${error}`);
}

try {
  const settings = await cache.fetch(key);
  return settings;
} catch (error) {
  logger.error(`Cache fetch failed: ${error}`);
}

// SUSPICIOUS: Identical, could be refactored
try {
  const result = await api.call1();
  return result;
} catch (error) {
  console.log(error);  // Generic logging
}

try {
  const result = await api.call2();
  return result;
} catch (error) {
  console.log(error);  // Identical
}
```

---

## 8. Language-Specific Idioms

### JavaScript/TypeScript
```javascript
// Valid idiomatic patterns (don't flag):
const { name, email } = user;           // Destructuring
data?.property?.nested                  // Optional chaining
response.json().then(r => process(r))   // Chaining
```

### Python
```python
# Valid idiomatic patterns (don't flag):
items = [x for x in data if x > 0]      # List comprehension
with open(file) as f: ...               # Context manager
**kwargs, *args                         # Variadic args
```

### Go
```go
// Valid idiomatic patterns (don't flag):
if err != nil { return err }            // Standard error check
defer f.Close()                         // Cleanup
package main                            // Standard structure
```

---

## 9. Template/Placeholder Code

### The Problem
```javascript
// Is this AI-generated or just a template?

function example() {
  // TODO: Implement this
  return null;
}

async function process() {
  // FIXME: Add error handling
  return await fetch(url);
}
```

### The Solution

**Template indicators (DO flag as AI-generated):**
- "TODO:" or "FIXME:" comments
- Placeholder return values (`null`, `undefined`, `0`)
- Stub implementations
- Without corresponding implementation

**BUT:** Only flag if:
1. Multiple instances
2. Combined with other AI indicators
3. Not in a legitimate WIP branch

---

## 10. Mixed AI and Human Code

### The Problem
```javascript
// Hand-written initialization
function setupConfig() {
  const config = {
    host: 'localhost',
    port: 8080
  };
  
  // AI-generated processing
  async function process(data) {
    try {
      const result = await operation();
      return result;
    } catch (error) {
      console.log(error);
    }
  }
  
  return config;
}
```

Some parts clearly hand-written, some parts suspicious.

### The Solution

**Report per-function:**
```
FILE: setupConfig.js

✓ Hand-written: setupConfig() - Clear, intentional
? AI-generated: process() - Generic names, boilerplate pattern
? Unknown: operation() - Suspicious but need more context

Overall: Mixed code detected (40% human, 60% AI indicators)
```

Give detailed breakdown instead of blanket assessment.

---

## Handling Complex Cases

### The Rule of Context
When in doubt, **assume legitimate unless multiple indicators present:**

```
1 indicator (generic names alone) → 10% AI likelihood
2 indicators (+ boilerplate) → 35% AI likelihood
3 indicators (+ over-commenting + template comments) → 70% AI likelihood
4+ indicators → 85%+ AI likelihood
```

### The Honesty Rule
When truly unsure, **say so:**

```
🤖 AI-GENERATED ASSESSMENT: Uncertain

Possible indicators:
- Generic names (could be legitimate context)
- Boilerplate pattern (could be framework)

Confidence: Low (20-40%)

Recommendation: Code looks fine, possible AI indicators but not definitive.
Review context and coding style for final decision.
```

Better to say "uncertain" than "definitely AI-generated" when evidence is mixed.

---

## Implementation Checklist

When evaluating code, ask:

- [ ] Are generic names used with clear context?
- [ ] Is this a known framework pattern?
- [ ] Are comments explaining "why" or just "what"?
- [ ] Is boilerplate identical (verbatim) or just similar pattern?
- [ ] Is this code style consistent throughout the file?
- [ ] Could this be intentional verbose style?
- [ ] Is there a legitimate reason for the pattern?
- [ ] Are multiple independent indicators present?
- [ ] Could this be vendor/auto-generated code?
- [ ] Would a human developer make the same choices?

**Only flag if:** Multiple indicators present AND can't be explained by context/style/framework.

---

**Version:** 1.0.0  
**Last Updated:** 2026-06-03  
**Purpose:** Reduce false positives in AI-generated code detection through context-aware analysis
