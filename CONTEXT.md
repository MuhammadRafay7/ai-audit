# ai-audit: Project Context

Project context, architecture, and design decisions for the ai-audit skill.

## What is ai-audit?

A Claude Code skill (`/ai-audit`) that analyzes uncommitted code changes to identify:
- **Errors & Bugs** — Logic errors, security issues, missing error handling
- **Code Quality** — Function length, complexity, documentation
- **AI-Generated Patterns** — Generic code, boilerplate, over-commenting
- **Best Practices** — Language/framework conventions
- **Code Duplication** — Repeated code patterns

## Why Does It Exist?

### Problem
- Developers mix AI-generated and hand-written code without clear distinction
- Common code quality issues go unnoticed before commit
- Duplicated code accumulates
- Hard to catch patterns that suggest AI generation

### Solution
A skill that:
- Automatically analyzes changes before commit
- Detects AI-generated code patterns
- Suggests best practice improvements
- Finds code duplication
- Helps developers write better code

## Target Users

- **Developers** — Using Claude to help write code
- **Teams** — Maintaining consistent code quality
- **Learners** — Understanding best practices
- **Code Reviewers** — Getting baseline analysis before review

## Architecture

### How It Works

1. **Input** — User runs `/ai-audit` in a git repository
2. **Capture** — Gets uncommitted changes via `git diff HEAD`
3. **Analyze** — Claude examines the code for:
   - Errors (parsing code semantically)
   - AI patterns (pattern matching)
   - Best practices (rule checking)
   - Duplication (code similarity)
4. **Report** — Displays structured analysis with:
   - Critical issues first
   - Actionable recommendations
   - Quality score (1-10)
   - Summary

### Data Flow

```
User runs /ai-audit
        ↓
Get git diff HEAD
        ↓
Extract file contents
        ↓
Claude analyzes for:
  ├── Errors
  ├── AI patterns
  ├── Best practices
  └── Duplication
        ↓
Generate report
        ↓
Display to user
```

## Design Decisions

### 1. Automatic Analysis (No Arguments)
**Decision:** Analyze all uncommitted changes automatically  
**Rationale:** Lower friction, catch all issues, doesn't require configuration  
**Trade-off:** Less control per invocation, all changes analyzed

### 2. All Languages Support
**Decision:** Support all programming languages  
**Rationale:** Users work with mixed stacks, one skill for all projects  
**Trade-off:** Language-specific rules less granular

### 3. AI Pattern Detection
**Decision:** Include AI-generated code detection  
**Rationale:** Users mix AI and human code, need to distinguish  
**Trade-off:** Some false positives/negatives possible

### 4. Scoring System (1-10)
**Decision:** Single quality score with breakdown  
**Rationale:** Easy to understand at a glance, encourages improvement  
**Trade-off:** Oversimplifies complex quality metrics

### 5. No Auto-Fix
**Decision:** Suggest improvements, don't auto-apply  
**Rationale:** Keep human in control of code changes  
**Trade-off:** Requires manual effort to implement suggestions

## Key Features

### 1. Error Detection
- Identifies bugs before commit
- Catches security issues
- Flags logic errors
- Warns about missing error handling

### 2. AI Pattern Recognition
- Detects generic variable names
- Identifies boilerplate code
- Finds over-commented code
- Spots placeholder implementations

### 3. Quality Metrics
- Function length analysis
- Complexity scoring
- Documentation checking
- Naming consistency

### 4. Duplication Analysis
- Finds repeated code blocks
- Identifies similar patterns
- Suggests extraction points
- Counts duplication percentage

### 5. Actionable Output
- Prioritized recommendations
- Specific line numbers
- Fix suggestions
- Learning points

## Configuration

### Default Behavior
- Analyzes all uncommitted changes
- Medium severity threshold
- 30% AI confidence threshold
- Detailed report enabled
- Common paths ignored (node_modules, dist, etc.)

### Customization
Create `.ai-audit-config.json`:
```json
{
  "ignorePaths": ["..."],
  "severityThreshold": "low|medium|high",
  "aiGeneratedThreshold": 0.0-1.0,
  "analyzeUnstagedOnly": true/false,
  "enableDetailedReport": true/false
}
```

## Limitations

1. **No Real-Time Fixing** — Suggests fixes, doesn't apply them
2. **Pattern-Based** — Can have false positives in AI detection
3. **Staged or Unstaged** — Doesn't analyze committed code
4. **No Git History** — Only current changes, no history analysis
5. **Language-Agnostic** — Language-specific rules are generic

## Future Enhancements

### Phase 2
- [ ] Auto-apply suggested fixes
- [ ] Integration with CI/CD
- [ ] Performance profiling
- [ ] Custom rule creation
- [ ] Report export (JSON, HTML, PDF)

### Phase 3
- [ ] Historical tracking
- [ ] Team comparison
- [ ] Slack/Teams integration
- [ ] PR comment automation
- [ ] Machine learning improvements

### Phase 4
- [ ] IDE real-time analysis
- [ ] Git hook integration
- [ ] Dashboard/metrics
- [ ] Team analytics
- [ ] Custom AI model fine-tuning

## Success Metrics

### User Perspective
- Catches errors before commit ✓
- Identifies AI-generated code ✓
- Improves code quality ✓
- Suggests best practices ✓
- Easy to use (`/ai-audit`) ✓

### Project Perspective
- High adoption rate
- Positive user feedback
- Active contributions
- Few bug reports
- Growing feature set

## Related Projects

- **code-review** — Claude Code built-in skill
- **simplify** — Code simplification
- **verify** — Run and test code
- **grill-me** — Design questioning skill
- **mattpocock-skills** — Skill collection framework

## Technology Stack

- **Claude Code** — Execution environment
- **Claude (Model)** — Code analysis AI
- **Git** — Version control integration
- **Markdown** — Documentation format
- **JSON** — Configuration format

## Community

This is an open-source project. Contributions welcome!

- Report issues on GitHub
- Submit pull requests
- Share examples
- Suggest features
- Help improve documentation

## Maintenance

### Regular Tasks
- Update examples with new features
- Review and respond to issues
- Merge contributions
- Test with new Claude Code versions
- Update documentation

### Release Schedule
- Bug fixes: ASAP
- Features: Monthly
- Major versions: Quarterly

---

**Document Version:** 1.0.0  
**Last Updated:** 2026-06-03  
**Status:** Active Development
