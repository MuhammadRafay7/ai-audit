# Contributing to ai-audit

Thank you for your interest in contributing to the ai-audit skill! This document provides guidelines for contributing.

## Code of Conduct

- Be respectful and inclusive
- Welcome diverse perspectives
- Focus on the code, not the person
- Help others improve their work

## Ways to Contribute

### 1. Report Issues
Found a bug? Have a suggestion?

1. Check existing issues first
2. Provide:
   - Clear description
   - Steps to reproduce
   - Expected vs actual behavior
   - Your environment (OS, Claude Code version)

Example:
```
Title: /ai-audit not detecting duplicate functions

Description:
When I have two identical functions in different files, 
the skill doesn't detect them as duplication.

Steps:
1. Create auth.ts with validateEmail() function
2. Create helpers.ts with same validateEmail() function
3. Run /ai-audit
4. No duplication detected

Expected: Should flag both instances as duplicate
Actual: No duplication message appears

Environment: macOS 12.x, Claude Code 1.2.0
```

### 2. Improve Documentation

Documentation improvements are always welcome:

- Fix typos
- Clarify confusing sections
- Add examples
- Update installation instructions
- Improve README structure

### 3. Add Features

Ideas for new features:

- [ ] Language-specific rule sets
- [ ] Integration with CI/CD pipelines
- [ ] Custom rule creation
- [ ] Performance profiling
- [ ] Visual report generation
- [ ] Slack/Teams notifications
- [ ] Historical tracking
- [ ] Automated fixes

### 4. Improve Detection

Help improve code analysis:

- Better AI-generation detection patterns
- Additional error signatures
- More best practice rules
- Language-specific improvements
- Edge case handling

### 5. Extend Language Support

Add support for more languages:
- Kotlin, Swift, Ruby, PHP
- MATLAB, R, Scala
- Bash, Shell scripts
- CSS/SCSS, HTML

## Development Setup

### 1. Fork the Repository

Click "Fork" on GitHub to create your copy.

### 2. Clone Your Fork

```bash
git clone https://github.com/YOUR-USERNAME/ai-audit.git
cd ai-audit
```

### 3. Create a Feature Branch

```bash
git checkout -b feature/your-feature-name
```

Use descriptive branch names:
- `feature/add-python-rules`
- `fix/null-check-detection`
- `docs/improve-readme`
- `refactor/simplify-analysis`

## Making Changes

### Edit Files

1. Make your changes
2. Test thoroughly
3. Keep changes focused and minimal
4. Write clear commit messages

### Commit Messages

```
[type]: Brief description

Longer explanation if needed.

Fixes #123 (if fixing an issue)
```

Types:
- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation
- `refactor:` Code refactoring
- `test:` Tests
- `chore:` Maintenance

Examples:
```
feat: Add Python best practice rules

fix: Detect empty catch blocks

docs: Improve installation guide

refactor: Simplify duplication detection algorithm
```

## Testing

### Test Your Changes

1. **Install locally:**
   ```bash
   cp -r . ~/.claude/skills/ai-audit
   ```

2. **Test in multiple scenarios:**
   - New project with simple code
   - Large project with complex code
   - Different programming languages
   - With and without configuration

3. **Test edge cases:**
   - Empty repository
   - No changes
   - Very large file
   - Binary files

### Create Test Files

If adding a feature, create test cases:

```
tests/
├── python/
│   ├── good.py
│   ├── bad.py
│   └── expected_output.md
├── javascript/
│   ├── good.js
│   ├── bad.js
│   └── expected_output.md
└── README.md
```

## Pull Request Process

### 1. Update Your Branch

```bash
git fetch origin
git rebase origin/main
```

### 2. Push Your Changes

```bash
git push origin feature/your-feature-name
```

### 3. Create Pull Request

On GitHub:
1. Click "New Pull Request"
2. Select your branch
3. Fill in description:

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation
- [ ] Refactoring

## How to Test
Steps to verify the changes

## Checklist
- [ ] Code follows style guidelines
- [ ] Documentation updated
- [ ] Tested on multiple setups
- [ ] No breaking changes
```

### 4. Code Review

- Respond to feedback
- Make requested changes
- Update your PR branch:
  ```bash
  git push origin feature/your-feature-name
  ```

### 5. Merge

Once approved, your changes will be merged!

## Style Guide

### Documentation

- Use Markdown
- Clear headers and sections
- Code examples with syntax highlighting
- Links to related content

### File Naming

- `FEATURE.md` — Features
- `BUG_FIX.md` — Bug fixes
- `config.template.json` — Configuration templates

### Comments

- Only when code isn't self-documenting
- Explain the "why", not the "what"
- Keep comments up-to-date

## Review Criteria

PRs are reviewed for:

1. **Correctness** — Does it work as intended?
2. **Quality** — Is the code well-written?
3. **Testing** — Is it tested?
4. **Documentation** — Is it documented?
5. **Compatibility** — Does it break anything?

## Community

- Discuss ideas in issues
- Share your improvements
- Help review others' PRs
- Give feedback on new features

## Licensing

By contributing, you agree your work is licensed under MIT License.

## Questions?

- Open an issue
- Ask in discussions
- Email the maintainer

---

**Thank you for contributing!** Your help makes ai-audit better for everyone.
