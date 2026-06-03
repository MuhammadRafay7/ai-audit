#!/bin/bash

# ai-audit Verification Script
# Verifies that ai-audit is properly installed and working

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}🔍 ai-audit Verification Script${NC}"
echo "=================================="
echo ""

# Check 1: Git is installed
echo -e "${YELLOW}[1/5] Checking git...${NC}"
if command -v git &> /dev/null; then
    echo -e "${GREEN}✅ Git installed ($(git --version))${NC}"
else
    echo -e "${RED}❌ Git not found. Please install git.${NC}"
    exit 1
fi

# Check 2: Claude Code skills directory exists
echo -e "${YELLOW}[2/5] Checking Claude Code directory...${NC}"
if [[ "$OSTYPE" == "darwin"* ]] || [[ "$OSTYPE" == "linux-gnu"* ]]; then
    SKILLS_DIR="$HOME/.claude/skills"
else
    SKILLS_DIR="$USERPROFILE\.claude\skills"
fi

if [ -d "$SKILLS_DIR" ]; then
    echo -e "${GREEN}✅ Skills directory found: $SKILLS_DIR${NC}"
else
    echo -e "${RED}❌ Skills directory not found: $SKILLS_DIR${NC}"
    echo "   Please install Claude Code first."
    exit 1
fi

# Check 3: ai-audit is installed
echo -e "${YELLOW}[3/5] Checking ai-audit installation...${NC}"
if [ -d "$SKILLS_DIR/ai-audit" ]; then
    echo -e "${GREEN}✅ ai-audit found at: $SKILLS_DIR/ai-audit${NC}"
else
    echo -e "${RED}❌ ai-audit not found in: $SKILLS_DIR${NC}"
    echo "   Run: ./scripts/install.sh"
    exit 1
fi

# Check 4: Required files exist
echo -e "${YELLOW}[4/5] Checking required files...${NC}"
REQUIRED_FILES=("SKILL.md" "README.md" "CONTRIBUTING.md" "LICENSE")
for file in "${REQUIRED_FILES[@]}"; do
    if [ -f "$SKILLS_DIR/ai-audit/$file" ]; then
        echo -e "${GREEN}✅ $file${NC}"
    else
        echo -e "${RED}❌ $file missing${NC}"
        exit 1
    fi
done

# Check 5: Test with git repo
echo -e "${YELLOW}[5/5] Testing with git repository...${NC}"
if git rev-parse --git-dir > /dev/null 2>&1; then
    echo -e "${GREEN}✅ In a git repository${NC}"

    # Check for uncommitted changes
    if ! git diff-index --quiet HEAD -- 2>/dev/null || [ -n "$(git status --short)" ]; then
        echo -e "${GREEN}✅ Uncommitted changes detected${NC}"
        echo ""
        echo -e "${BLUE}Ready to use! Try:${NC}"
        echo "  /ai-audit"
    else
        echo -e "${YELLOW}⚠️  No uncommitted changes${NC}"
        echo "   Make a test change first: echo 'test' > testfile.txt"
        echo "   Then run: /ai-audit"
    fi
else
    echo -e "${YELLOW}⚠️  Not in a git repository${NC}"
    echo "   Create one with: git init"
    echo "   Then: /ai-audit"
fi

echo ""
echo -e "${GREEN}✨ Verification Complete!${NC}"
echo ""
echo -e "${BLUE}📚 Resources:${NC}"
echo "- Documentation: $SKILLS_DIR/ai-audit/README.md"
echo "- Installation: $SKILLS_DIR/ai-audit/docs/installation.md"
echo "- Examples: $SKILLS_DIR/ai-audit/docs/examples.md"
echo "- Contributing: $SKILLS_DIR/ai-audit/CONTRIBUTING.md"
echo ""
