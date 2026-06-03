# ai-audit

Code analysis framework for Claude Code. **Alpha status: unvalidated.**

## What This Is

Instructions for Claude Code to analyze uncommitted changes for:

- Obvious errors (missing error handling, null checks)
- Code quality issues (long functions, duplication)
- Possible AI-generated patterns

**Status:** Not tested on real code. Everything is theoretical.

## Install

```bash
mkdir -p ~/.claude/skills
git clone <repo-url> ~/.claude/skills/ai-audit
# Restart Claude Code
```

## Use

```bash
cd your-project
/ai-audit
```

## Help Validate

This alpha needs real-world testing. Test it on your code:

1. See [VALIDATION_PROTOCOL.md](VALIDATION_PROTOCOL.md) for step-by-step
2. Use [VALIDATION_TEMPLATE.md](VALIDATION_TEMPLATE.md) to report
3. Test scenarios in `tests/scenarios/`

Report results: open GitHub issue with your findings.

Report results: open GitHub issue with your findings.

## What's Known

- Framework is complete and documented
- It hasn't been validated on real code
- Accuracy is unknown
- Sample outputs are theoretical

## Documentation

- [SKILL.md](SKILL.md) - How the analysis works
- [VALIDATION.md](VALIDATION.md) - Testing results (contribute yours)
- [docs/](docs/) - Guides, architecture, examples

## Limitations

Can't detect:

- Architectural problems
- Complex logic errors
- Performance issues
- Business logic correctness

See [docs/limitations.md](docs/limitations.md) for full list.

## Status

**v0.1.0-alpha** - Seeking validation

Roadmap:

- v0.2: Real test data collected
- v0.3: Heuristics refined
- v1.0: Production-ready (after validation)

---

Help improve this by testing and reporting results.
