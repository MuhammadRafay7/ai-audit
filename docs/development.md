# ai-audit: Claude Code Instructions

Instructions for Claude Code when working with the ai-audit skill project.

## Project Overview

**ai-audit** is a Claude Code skill that automatically analyzes uncommitted code changes for:
- Errors and bugs
- Code quality issues
- AI-generated code patterns
- Best practice violations
- Code duplication

## Key Files

- `SKILL.md` — Skill definition and user documentation
- `README.md` — Project overview and features
- `CONTEXT.md` — Project context and architecture
- `docs/` — Detailed documentation
- `scripts/` — Setup and verification scripts
- `config.template.json` — Configuration template

## Development Guidelines

### When Making Changes

1. **Update SKILL.md** if user-facing behavior changes
2. **Update README.md** if features/capabilities change
3. **Add docs** for new functionality
4. **Keep examples current** in docs/examples.md
5. **Test thoroughly** before committing

### Code Style

- Clear, concise documentation
- Examples for all major features
- Links between related docs
- Markdown formatting for readability

### Adding Features

1. Update SKILL.md with new capability
2. Add documentation in docs/
3. Create examples in docs/examples.md
4. Update README.md features list
5. Create ADR in docs/adr/ if architectural

## File Organization

```
ai-audit/
├── SKILL.md              # Skill definition
├── README.md             # Overview & features
├── CLAUDE.md            # This file
├── CONTEXT.md           # Project context
├── CONTRIBUTING.md      # Contribution guide
├── LICENSE              # MIT
├── config.template.json # Config template
├── docs/
│   ├── installation.md  # Setup instructions
│   ├── examples.md      # Usage examples
│   ├── guides/          # How-to guides
│   └── adr/             # Architecture decisions
└── scripts/             # Helper scripts
```

## Common Tasks

### Install Locally
```bash
cp -r . ~/.claude/skills/ai-audit
```

### Verify Installation
```bash
# In any git repo with changes:
/ai-audit
```

### Update Docs
1. Edit relevant .md files
2. Keep examples up-to-date
3. Update table of contents
4. Test links work

### Add New Feature
1. Design in docs/adr/
2. Document in docs/guides/
3. Add examples
4. Update SKILL.md

## Documentation Standards

- H1 for titles
- H2 for main sections
- Use tables for comparisons
- Include code examples
- Link to related docs
- Keep under 200 lines when possible

## Before Sharing/Publishing

- [ ] All docs are current
- [ ] Examples are accurate
- [ ] Installation steps tested
- [ ] Configuration documented
- [ ] Troubleshooting covers common issues
- [ ] Links all work
- [ ] No broken references

## Maintenance

- Review issues regularly
- Update docs with feedback
- Keep examples current
- Test with multiple Claude Code versions
- Document any breaking changes

## Contributing

See CONTRIBUTING.md for:
- How to report issues
- Feature request process
- Pull request guidelines
- Code review criteria
- Development setup

## License

MIT License - See LICENSE file

---

**Version:** 1.0.0  
**Last Updated:** 2026-06-03  
**Maintained By:** [Your Name]
