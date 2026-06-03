# Validation Results

Results from real-world testing of ai-audit.

## Contribute Results

Help validate ai-audit by testing it and reporting your findings.

**See [VALIDATION_PROTOCOL.md](VALIDATION_PROTOCOL.md)** for step-by-step testing guide.

**Use [VALIDATION_TEMPLATE.md](VALIDATION_TEMPLATE.md)** to format your report.

## Published Results

Results will be listed here as they come in.

### Status: No results yet

This is an unvalidated alpha. The first real-world test results will appear here.

**Be the first to test and report!**

## How to Report

### Option 1: GitHub Issue
1. Run tests using [VALIDATION_PROTOCOL.md](VALIDATION_PROTOCOL.md)
2. Fill template from [VALIDATION_TEMPLATE.md](VALIDATION_TEMPLATE.md)
3. Create GitHub issue: `Validation Results: [Your Name] - [Date]`
4. Paste the completed template

### Option 2: Pull Request
1. Complete testing and template
2. Add result to `RESULTS/` directory as markdown file
3. Create pull request with title: `Validation: [Your Name] - [Date]`

## Data We're Collecting

For each test run, we collect:

- **Test scenarios** - Which predefined tests were run
- **Accuracy per scenario** - How many known issues were found
- **False positive rate** - How many non-issues were reported
- **Real code results** - Testing on actual projects
- **Environment** - OS, Claude Code version, etc.
- **Qualitative feedback** - What worked, what didn't

## Current Statistics

```
Total test runs: 0
Average accuracy: N/A
Best performing scenario: N/A
Worst performing scenario: N/A
Average false positive rate: N/A
```

*(Will update as results come in)*

## Test Scenario Breakdown

When enough results are collected, we'll show:

| Scenario | Tests Run | Avg Accuracy | False Positives | Pass Rate |
|----------|-----------|--------------|-----------------|-----------|
| missing-error-handling | 0 | N/A | N/A | N/A |
| null-reference | 0 | N/A | N/A | N/A |
| code-duplication | 0 | N/A | N/A | N/A |

## What Counts as Valid Testing

To be included in validation results:

✓ **Include:**
- Completed template from VALIDATION_TEMPLATE.md
- Environment details (OS, Claude Code version)
- Results from at least one test scenario
- Honest assessment (even if accuracy is low)
- Your real observations

✗ **Don't include:**
- Incomplete results
- Hypothetical testing ("I think it would...")
- Results without environment info
- Copied/fake data

## How Accuracy is Calculated

```
Accuracy = (Known Issues Found) / (Total Known Issues) × 100%

Example:
Scenario has 2 known issues
ai-audit finds 1 of them
Accuracy = 1/2 = 50%
```

If ai-audit reports false issues (not in the code), that's:

```
False Positives = (Issues Reported) - (Known Issues)

Example:
2 known issues
ai-audit reports 3 issues (1 is not actually there)
False Positives = 1
Accuracy = 2/2 = 100% (still found all known issues)
But False Positive Rate = 1/3 = 33%
```

## Trends We're Watching

As data comes in, we'll track:

- **Accuracy trending up or down** - Are heuristics improving?
- **False positive rate** - Acceptable? <15%?
- **Which scenarios are harder** - Where does the skill struggle?
- **False negatives per category** - What errors are being missed?
- **Environment differences** - Does OS/version matter?

## Feedback Loop

1. **Results come in** → Added to VALIDATION.md
2. **Patterns emerge** → SKILL.md heuristics refined
3. **New version released** → People re-test
4. **Cycle repeats** → Accuracy improves over time

## Timeline

- **June 2026** - Alpha released, seeking initial validation
- **July 2026** - First 5-10 test runs expected, initial accuracy data
- **Aug 2026** - 20+ test runs, heuristics refined, v0.2-alpha
- **Sep 2026** - 50+ test runs, accuracy target 75%+, v1.0-beta
- **Oct 2026** - Real-world usage feedback, v1.0-stable

## Known Testing Challenges

Some observations about what's hard to validate:

**Easy to validate:**
- Error detection (obvious bugs are clear)
- Duplication detection (exact matches are obvious)
- Code quality (function length is measurable)

**Hard to validate:**
- AI-pattern detection (subjective - is generic naming code AI-generated or just simple code?)
- Best practices (varies by language/framework)
- Edge cases (miss/false positive rates require large sample size)

## Related Docs

- [VALIDATION_PROTOCOL.md](VALIDATION_PROTOCOL.md) - How to test
- [VALIDATION_TEMPLATE.md](VALIDATION_TEMPLATE.md) - How to report
- [tests/scenarios/](tests/scenarios/) - Test code samples
- [docs/limitations.md](docs/limitations.md) - Known limitations
- [CHANGELOG.md](CHANGELOG.md) - Version history

## Questions?

Confused about how to validate? 

- Read [VALIDATION_PROTOCOL.md](VALIDATION_PROTOCOL.md) first
- Look at [VALIDATION_TEMPLATE.md](VALIDATION_TEMPLATE.md) for format
- Run the test scenarios in `tests/scenarios/`
- Open an issue if something isn't clear

---

**Version:** 0.1.0-alpha
**Status:** Seeking initial validation
**Last updated:** 2026-06-03

Help us validate ai-audit. Test it, report results, and help make it better.
