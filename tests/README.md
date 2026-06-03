# ai-audit Test Suite

Tests to validate that ai-audit works correctly.

## Running Tests

### Automated Tests
```bash
./tests/run-tests.sh
```

This runs:
- **File structure tests** — Verify all required files exist
- **Format tests** — Check syntax and formatting
- **Content tests** — Verify key sections exist
- **Configuration tests** — Validate config structure
- **Documentation quality** — Check docs completeness

### Manual Testing

For real-world validation, see `docs/validation-testing.md`

```bash
# Create test repository
mkdir test-repo && cd test-repo
git init

# Copy test case files
cp ../tests/test-cases/* .

# Run skill
/ai-audit

# Compare output to expected results
```

## Test Categories

### 1. Syntax Tests
- ✓ SKILL.md markdown syntax
- ✓ Scripts bash syntax
- ✓ JSON configuration syntax
- ✓ File encoding (UTF-8)

### 2. Structure Tests
- ✓ Critical files exist (SKILL.md, README.md, CHANGELOG.md)
- ✓ Documentation folder complete
- ✓ Scripts folder has install/verify scripts
- ✓ Configuration template exists

### 3. Content Tests
- ✓ SKILL.md has required sections
- ✓ README.md has installation guide
- ✓ CHANGELOG.md has version entries
- ✓ Limitations documented
- ✓ Examples provided

### 4. Quality Tests
- ✓ No obvious placeholders (yourusername, FIXME_REQUIRED)
- ✓ No trailing whitespace
- ✓ Proper line endings
- ✓ Consistent formatting

### 5. Configuration Tests
- ✓ config.template.json is valid
- ✓ Field types correct
- ✓ Documented in SKILL.md

## Test Results

### Current Status
- **Last Run:** 2026-06-03
- **Status:** ✓ Passing
- **Coverage:** File structure, syntax, content
- **Missing:** Real accuracy validation (requires git repo)

### What's Tested
- ✓ All files present
- ✓ All markdown valid
- ✓ All JSON valid
- ✓ All scripts syntactically correct
- ✓ Documentation complete
- ✓ No obvious errors

### What's Not Yet Tested
- ⏳ Real skill performance (requires `/ai-audit` invocation)
- ⏳ Accuracy metrics (requires validation suite run)
- ⏳ False positive rate (requires real code samples)
- ⏳ AI-detection accuracy (requires known AI-generated samples)

## Test Cases

See `test-cases/` directory for example code files used in validation testing:

- `missing-error-handling.js` — Should detect error handling issue
- `null-reference.ts` — Should detect null reference
- `long-function.js` — Should flag >50 lines
- `duplicate-validation.js` — Should find code duplication
- `ai-generated.js` — Should detect boilerplate patterns
- `legitimate-code.js` — Should NOT flag legitimate code

## Running Individual Test Categories

```bash
# Just syntax tests
bash -n tests/run-tests.sh

# Just structure tests
grep -l "test.*exists" tests/run-tests.sh

# Create a simple test repo
mkdir -p /tmp/ai-audit-test
cd /tmp/ai-audit-test
git init
echo "const x = 1;" > test.js
git add test.js
/ai-audit
```

## CI/CD Integration

The `.github/workflows/validate.yml` runs these tests on:
- ✓ Every push to main/develop
- ✓ Every pull request
- ✓ Manual trigger

Results visible in GitHub Actions tab.

## Adding New Tests

To add a test case:

1. Create file in `tests/test-cases/`
2. Name clearly (e.g., `missing-error-handling.js`)
3. Add comment explaining expected issue
4. Update `docs/validation-testing.md` with expected output
5. Run `/ai-audit` on file to document actual output

## Expected Test Output

```
════════════════════════════════════════════════════════════════
  ai-audit Test Suite
════════════════════════════════════════════════════════════════

[Unit Tests: File Structure]
Testing: SKILL.md exists... ✓ PASS
Testing: README.md exists... ✓ PASS
Testing: CHANGELOG.md exists... ✓ PASS
...

════════════════════════════════════════════════════════════════
  Test Summary
════════════════════════════════════════════════════════════════

Passed:  25
Failed:  0
Skipped: 0
Total:   25

✓ All tests passed!
```

## Troubleshooting

### Test fails with "file not found"
Ensure you're running from project root:
```bash
cd /path/to/ai-audit
./tests/run-tests.sh
```

### JSON validation fails
Check that `config.template.json` is valid:
```bash
python3 -m json.tool config.template.json
```

### Script syntax fails
Check bash syntax:
```bash
bash -n scripts/install.sh
```

## Maintenance

- Update tests when features change
- Add tests for reported bugs before fixing
- Run tests before every release
- Document any skipped tests and why

## Future Test Coverage

- [ ] Real accuracy metrics (50+ code samples)
- [ ] AI-detection validation
- [ ] Language-specific coverage (Python, Go, Rust)
- [ ] Framework pattern recognition (Django, React, Spring)
- [ ] Performance benchmarks
- [ ] False positive baselines

---

**Last Updated:** 2026-06-03  
**Next Review:** When adding new features or based on user feedback
