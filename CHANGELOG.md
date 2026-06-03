# Changelog

All notable changes to ai-audit are documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/), and this project adheres to [Semantic Versioning](https://semver.org/).

## Versioning Strategy

- **MAJOR** (X.0.0): Breaking changes to analysis output or API
- **MINOR** (0.X.0): New features, improved heuristics, new languages
- **PATCH** (0.0.X): Bug fixes, documentation, config improvements

### Version Stability

- **v1.x.x**: Production-ready, stable API
- **v0.x.x**: Beta, may have breaking changes

---

## [Unreleased]

### Planned
- [ ] Run validation suite on 50+ real code samples
- [ ] Document actual accuracy metrics
- [ ] Add language-specific rules (Python, Go, Rust)
- [ ] CI/CD pipeline setup
- [ ] Test suite for skill itself
- [ ] Configuration error validation
- [ ] Integration with ESLint/TSLint output

---

## [0.1.0-alpha] - 2026-06-03

### Status
**UNVALIDATED ALPHA** - Framework complete, accuracy unknown.
Has not been tested on real code.
Heuristics are theoretical.
Help validate by testing and reporting results.

See [VALIDATION.md](VALIDATION.md) for how to contribute testing.

### Added - Skill Core
- **Analysis Framework**: Instructions for Claude to analyze code for errors, quality issues, duplications
- **Weighted Scoring System**: Framework for AI-pattern detection (low/moderate/high confidence)
- **Error Detection heuristics**: Rules to identify missing error handling, null checks, type issues
- **Code Quality heuristics**: Rules for function length, naming, documentation
- **Duplication detection**: Framework to identify repeated code
- **Quality scoring**: 1-10 rating formula

### Added - Testing & Validation
- **VALIDATION_PROTOCOL.md**: Step-by-step guide for testing ai-audit
- **VALIDATION_TEMPLATE.md**: Format for reporting test results
- **VALIDATION.md**: Collected results from community testing
- **tests/scenarios/**: 3 code samples with known issues for testing
  - 01-missing-error-handling: 2 obvious async errors
  - 02-null-reference: 2 missing null checks
  - 03-code-duplication: 2 identical code blocks

### Added - Documentation
- **README.md**: Honest status - unproven alpha framework
- **SKILL.md**: Instructions for Claude with analysis rules and heuristics
- **docs/**: 8 comprehensive guides
- **CLAUDE.md**: Developer guidelines
- **CONTEXT.md**: Architecture and design decisions
- **CONTRIBUTING.md**: How to contribute

### Added - Infrastructure
- **.github/workflows/validate.yml**: CI/CD for project structure validation
- **tests/run-tests.sh**: 34 automated checks of project structure
- **scripts/install.sh**: Installation helper script
- **scripts/verify.sh**: Installation verification
- **config.template.json**: Configuration example

### Known Limitations (v0.1.0-alpha)
**Everything is unproven.** This is a framework/instructions, not validated code.

Specific unknowns:
- **Error detection**: Untested on real code, accuracy unknown
- **AI-pattern detection**: Heuristic-based, high false positive rate expected
- **Code quality checks**: Theoretical, not validated
- **Duplication detection**: Untested
- **Overall accuracy**: Unknown, could be anywhere from 30-80%

### What This Is NOT
- ✗ Not production-ready
- ✗ Not battle-tested
- ✗ Not validated on real code
- ✗ Not proven to be accurate
- ✗ Not claiming any accuracy metrics (none exist yet)

### What's Needed
1. Real testing on 20+ code samples
2. Accuracy metrics (% errors caught, false positive rate)
3. Heuristic refinement based on failures
4. Community feedback and validation
5. Then: v0.2-alpha with real data

### Next Steps
- Run test scenarios from `tests/scenarios/`
- Report results using [VALIDATION_TEMPLATE.md](VALIDATION_TEMPLATE.md)
- Help identify what works and what doesn't
- Suggest improvements to heuristics
- [ ] Language-specific rule sets
- [ ] Performance profiling analysis
- [ ] Integration with external tools (ESLint, etc.)

---

## Release Notes

### v1.0.0 Status
**Status**: Beta (well-documented, ready for testing)

**What's Ready:**
- ✅ Skill specification complete
- ✅ Detailed documentation comprehensive
- ✅ Testing framework defined
- ✅ Edge cases documented
- ✅ Installation instructions clear

**What's Missing:**
- ❌ Validation suite not yet run
- ❌ Real accuracy metrics not gathered
- ❌ No CI/CD automation
- ❌ No tests for skill itself
- ❌ Config validation not implemented

**To Promote to v1.0.0 Stable:**
1. Run validation suite (50+ code samples)
2. Document accuracy metrics
3. Add CI/CD pipeline
4. Create skill tests
5. Implement config validation

---

## Future Roadmap

### v1.1.0 (Q3 2026)
- [ ] Configuration validation with error messages
- [ ] Language-specific rules (Python, Go, TypeScript)
- [ ] Integration with ESLint/Pylint output
- [ ] Improved AI-detection patterns
- [ ] Better handling of framework boilerplate

### v1.2.0 (Q4 2026)
- [ ] CI/CD pipeline setup (GitHub Actions)
- [ ] Automated tests for skill
- [ ] Performance analysis (basic)
- [ ] Historical tracking of code quality
- [ ] Team analytics/comparison

### v2.0.0 (2027)
- [ ] Auto-fix recommendations (safe changes only)
- [ ] IDE integration (VS Code plugin)
- [ ] Slack/Teams notifications
- [ ] Custom rule creation
- [ ] Machine learning improvements

---

## How to Read This Changelog

### For Users
Look for:
- **Added**: New features you can use
- **Improved**: Better analysis or accuracy
- **Fixed**: Bug fixes
- **Changed**: Breaking changes to usage

### For Developers
Look for:
- **Known Limitations**: What's not implemented
- **Technical Changes**: Architecture updates
- **Roadmap**: What's coming

### Version Stability
- **v1.x.x**: Stable, safe to use in production
- **v0.x.x**: Beta, breaking changes possible
- **Unreleased**: In development, not ready

---

## Contribution & Feedback

Found something missing? File an issue:
- [GitHub Issues](https://github.com/yourusername/ai-audit/issues)
- [Email](mailto:contact@example.com)

Want to contribute? See [CONTRIBUTING.md](CONTRIBUTING.md)

---

## Archive

### Removed Features
*(None yet - this is v1.0.0)*

### Deprecated Features
*(None yet - this is v1.0.0)*

### Security Advisories
*(None yet)*

---

**Last Updated:** 2026-06-03  
**Maintainers:** ai-audit contributors
