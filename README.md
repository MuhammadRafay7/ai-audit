# ai-audit

Framework for analyzing code changes. **Status: Alpha, unvalidated.**

## What This Is

Instructions for Claude Code to analyze your uncommitted code for:
- Obvious errors (missing error handling, null references, type mismatches)
- Code quality issues (long functions, naming problems, duplication)
- Possible AI-generated patterns (generic code, boilerplate, over-commenting)

## What's Proven

Nothing yet. This has not been tested on real code.

## What's Not Proven

- Does it actually catch bugs?
- What's the accuracy rate?
- False positive rate?
- Does AI-pattern detection work?
- Are the heuristics sound?

**We don't know. That's why we need testing.**

## Installation

```bash
# For macOS/Linux
mkdir -p ~/.claude/skills
git clone <REPOSITORY_URL> ~/.claude/skills/ai-audit

# For Windows PowerShell
New-Item -ItemType Directory -Path "$env:USERPROFILE\.claude\skills" -Force
git clone <REPOSITORY_URL> "$env:USERPROFILE\.claude\skills\ai-audit"
```

Then restart Claude Code.

## Usage

```bash
cd your-project
git add some-changes
/ai-audit
```

## Help Validate

This skill needs real-world testing. If you use it, **please report your results**.

### Quick Test
1. Run `/ai-audit` on your code
2. Check if it found real issues
3. Check if it found false issues
4. Open an issue with template: `/VALIDATION_TEMPLATE.md`

### What to Report
- Code sample (or repo link)
- What issues exist in the code
- What ai-audit found
- Were they correct? Missed? False alarms?
- Your assessment: accuracy %

See `VALIDATION.md` for existing results and how to contribute.

## Current Status

**v0.1.0-alpha**
- Framework complete
- Documentation complete
- Validation: pending (help needed)
- Real accuracy: unknown

## What's Here

- `SKILL.md` - Instructions for analysis
- `docs/` - Guides and documentation
- `tests/scenarios/` - Code samples for testing
- `tests/run-tests.sh` - Project validation (not skill validation)

## What's Missing

- Real testing on actual code
- Accuracy metrics
- False positive rate
- Validation from users
- Heuristic refinement based on failures

## Known Limitations

**Everything is theoretical.** Accuracy claims, sample outputs, heuristics — all are educated guesses that need validation.

Specific unknowns:
- AI-pattern detection is heuristic-based and unvalidated
- Error detection limited to what can be inferred from code reading
- Cannot detect architectural problems
- Cannot detect complex logic errors
- Cannot validate business logic
- Cannot do performance analysis

## How to Help

1. **Test it** - Use it on your code, report results
2. **Report findings** - Honest feedback (what worked, what failed)
3. **Contribute** - Documentation, test cases, heuristic ideas
4. **Discuss** - Open issues for any questions or observations

## Contributing

See `CONTRIBUTING.md` for how to contribute to development.

## License

MIT - Use freely.

---

**Version:** 0.1.0-alpha  
**Status:** Unvalidated framework, seeking real-world testing  
**Last updated:** 2026-06-03
