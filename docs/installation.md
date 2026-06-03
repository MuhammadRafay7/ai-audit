# Installation Guide

Complete instructions for installing the `ai-audit` skill in your Claude Code environment.

## Prerequisites

- Claude Code installed ([download here](https://claude.com/claude-code))
- Git installed on your system
- Access to your Claude Code configuration directory

## Installation Methods

### Method 1: Quick Installation (Recommended)

#### On macOS/Linux:
```bash
mkdir -p ~/.claude/skills
cd ~/.claude/skills
git clone https://github.com/yourusername/ai-audit.git
```

#### On Windows (PowerShell):
```powershell
New-Item -ItemType Directory -Path "$env:USERPROFILE\.claude\skills" -Force
cd "$env:USERPROFILE\.claude\skills"
git clone https://github.com/yourusername/ai-audit.git
```

#### On Windows (Command Prompt):
```cmd
mkdir %USERPROFILE%\.claude\skills
cd %USERPROFILE%\.claude\skills
git clone https://github.com/yourusername/ai-audit.git
```

### Method 2: Manual Installation

1. **Locate your Claude Code skills directory:**
   - **macOS/Linux:** `~/.claude/skills/`
   - **Windows:** `%USERPROFILE%\.claude\skills\`

2. **Create the skill folder:**
   ```bash
   mkdir ai-audit
   cd ai-audit
   ```

3. **Copy files into this folder:**
   - `SKILL.md`
   - `README.md`
   - `LICENSE`
   - Any other files from this repository

4. **Verify the structure:**
   ```
   ~/.claude/skills/ai-audit/
   ├── SKILL.md
   ├── README.md
   ├── LICENSE
   └── CONTRIBUTING.md
   ```

### Method 3: Project-Level Installation

Install the skill for a specific project:

```bash
# Navigate to your project
cd /path/to/your/project

# Create skills directory if it doesn't exist
mkdir -p .claude/skills

# Copy ai-audit into your project
cp -r /path/to/ai-audit .claude/skills/
```

This makes the skill available only within this project.

### Method 4: Download as ZIP

1. Go to [GitHub releases](https://github.com/yourusername/ai-audit/releases)
2. Download the latest `.zip` file
3. Extract to your `~/.claude/skills/` directory
4. Rename folder to `ai-audit` if needed

## Post-Installation Steps

### 1. Verify Installation

Check that the skill is accessible:

```bash
# Restart Claude Code (or reload VS Code)
# Then in any git repository, run:
/ai-audit

# You should see the analysis output
```

### 2. Grant Permissions (If Prompted)

Claude Code may ask for permission to:
- Run `git` commands
- Read file contents
- Access your working directory

Grant these permissions for the skill to work.

### 3. Configure (Optional)

Create `.ai-audit-config.json` in your project root:

```json
{
  "ignorePaths": ["node_modules", "dist", "build"],
  "analyzeUnstagedOnly": false,
  "severityThreshold": "medium",
  "aiGeneratedThreshold": 0.3,
  "enableDetailedReport": true
}
```

## Verification Checklist

- [ ] Files copied to correct location
- [ ] File permissions are readable (not required on Windows)
- [ ] Claude Code restarted/reloaded
- [ ] Not in a git repository (try `/ai-audit` in a test repo)
- [ ] Output appears without errors

## Troubleshooting

### Skill Not Found

**Problem:** `/ai-audit` command not recognized

**Solutions:**
1. Restart Claude Code completely
2. If using VS Code extension, reload window (`Cmd+Shift+P` → "Reload Window")
3. Verify folder exists at `~/.claude/skills/ai-audit/`
4. Check that `SKILL.md` is in the folder
5. Verify file permissions: `ls -la ~/.claude/skills/ai-audit/`

### Permission Denied

**Problem:** "Permission denied" when running the skill

**Solutions:**
1. Make files readable: `chmod +r ~/.claude/skills/ai-audit/*`
2. Make directory readable: `chmod +x ~/.claude/skills/ai-audit/`
3. Check git permissions: `git config --list`

### Not in Git Repository

**Problem:** "Not in a git repository" error

**Solutions:**
1. Navigate to a git repository
2. Or initialize one: `git init`
3. Make a change: `echo "test" > file.txt`
4. Try again: `/ai-audit`

### No Uncommitted Changes

**Problem:** "No uncommitted changes" message

**Solutions:**
1. Modify a file
2. Or stage changes: `git add .`
3. Or run: `git status` to verify
4. Try again: `/ai-audit`

### Claude Code Won't Grant Permissions

**Problem:** Permission prompts keep appearing

**Solutions:**
1. Grant permission once (click "Allow")
2. Update your Claude Code settings to trust the skill
3. Check `.claude/settings.json` for permission config

## Updating

### To Update the Skill

If you installed via git:

```bash
cd ~/.claude/skills/ai-audit
git pull origin main
```

If you downloaded as ZIP:

1. Download latest version
2. Extract over existing files
3. Restart Claude Code

## Uninstalling

To remove the skill:

```bash
# macOS/Linux
rm -rf ~/.claude/skills/ai-audit

# Windows PowerShell
Remove-Item -Recurse "$env:USERPROFILE\.claude\skills\ai-audit"

# Windows Command Prompt
rmdir /s %USERPROFILE%\.claude\skills\ai-audit
```

## System Requirements

| Requirement | Minimum | Recommended |
|---|---|---|
| Claude Code | Latest | Latest |
| Git | 2.20+ | 2.30+ |
| Node.js (if using VS Code ext) | 16+ | 18+ |
| Disk Space | 5 MB | 10 MB |
| RAM | N/A | N/A |

## Platform Support

✅ macOS (Intel & Apple Silicon)
✅ Linux (Ubuntu, Debian, CentOS)
✅ Windows 10/11
✅ WSL2

## Getting Help

- 📖 Read `README.md` for usage details
- 💬 Open an issue on GitHub
- 🐛 Report bugs with error messages
- 💡 Suggest improvements

## Next Steps

After installation:

1. Read the `README.md` for features and usage
2. Try `/ai-audit` in your first git repository
3. Customize with `.ai-audit-config.json` if needed
4. Check out `EXAMPLES.md` for real-world usage

---

**Installation Complete!** You're ready to use `/ai-audit`.
