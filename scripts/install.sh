#!/bin/bash

# ai-audit Installation Script
# Installs the ai-audit skill to your Claude Code configuration

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Determine OS and Claude Code skills directory
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    SKILLS_DIR="$HOME/.claude/skills"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    SKILLS_DIR="$HOME/.claude/skills"
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
    # Windows
    SKILLS_DIR="$USERPROFILE\.claude\skills"
else
    echo -e "${RED}❌ Unsupported OS: $OSTYPE${NC}"
    exit 1
fi

echo -e "${BLUE}🔧 ai-audit Installation Script${NC}"
echo "================================"
echo ""

# Create skills directory if it doesn't exist
echo -e "${YELLOW}📁 Creating skills directory...${NC}"
mkdir -p "$SKILLS_DIR"

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

# Copy ai-audit to skills directory
echo -e "${YELLOW}📋 Copying ai-audit files...${NC}"
INSTALL_DIR="$SKILLS_DIR/ai-audit"

if [ -d "$INSTALL_DIR" ]; then
    echo -e "${YELLOW}⚠️  ai-audit already exists at $INSTALL_DIR${NC}"
    read -p "Overwrite existing installation? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf "$INSTALL_DIR"
    else
        echo -e "${YELLOW}Installation cancelled.${NC}"
        exit 0
    fi
fi

# Copy files
cp -r "$PROJECT_DIR" "$INSTALL_DIR"

echo -e "${GREEN}✅ Files copied to: $INSTALL_DIR${NC}"
echo ""

# Set proper permissions
echo -e "${YELLOW}🔐 Setting permissions...${NC}"
chmod +r "$INSTALL_DIR"/*
chmod +x "$INSTALL_DIR" 2>/dev/null || true

echo -e "${GREEN}✅ Permissions set${NC}"
echo ""

# Verify installation
echo -e "${YELLOW}🔍 Verifying installation...${NC}"
if [ -f "$INSTALL_DIR/SKILL.md" ]; then
    echo -e "${GREEN}✅ SKILL.md found${NC}"
else
    echo -e "${RED}❌ SKILL.md not found${NC}"
    exit 1
fi

if [ -f "$INSTALL_DIR/README.md" ]; then
    echo -e "${GREEN}✅ README.md found${NC}"
else
    echo -e "${RED}❌ README.md not found${NC}"
    exit 1
fi

echo ""
echo -e "${GREEN}✨ Installation Complete!${NC}"
echo ""
echo -e "${BLUE}Next Steps:${NC}"
echo "1. Restart Claude Code (or reload VS Code)"
echo "2. Navigate to a git repository with uncommitted changes"
echo "3. Run: ${YELLOW}/ai-audit${NC}"
echo ""
echo -e "${BLUE}Documentation:${NC}"
echo "- Usage: $INSTALL_DIR/docs/installation.md"
echo "- Examples: $INSTALL_DIR/docs/examples.md"
echo "- README: $INSTALL_DIR/README.md"
echo ""
echo -e "${GREEN}Happy auditing!${NC}"
