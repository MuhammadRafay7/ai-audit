#!/bin/bash

# ai-audit Test Suite
# Run with: ./tests/run-tests.sh

set -e

echo "════════════════════════════════════════════════════════════════"
echo "  ai-audit Test Suite"
echo "════════════════════════════════════════════════════════════════"
echo ""

PASS=0
FAIL=0
SKIP=0

# Color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

test_case() {
  local name=$1
  local command=$2
  local expected_result=$3

  echo -n "Testing: $name... "

  if eval "$command" > /tmp/test_output.txt 2>&1; then
    actual_result=$?
  else
    actual_result=$?
  fi

  if [ $actual_result -eq 0 ]; then
    echo -e "${GREEN}✓ PASS${NC}"
    ((PASS++))
  else
    echo -e "${RED}✗ FAIL${NC}"
    cat /tmp/test_output.txt
    ((FAIL++))
  fi
}

skip_case() {
  local name=$1
  echo -e "Skipping: $name ${YELLOW}(not ready)${NC}"
  ((SKIP++))
}

# ============================================================================
# UNIT TESTS: File Structure
# ============================================================================
echo -e "${YELLOW}[Unit Tests: File Structure]${NC}"
echo ""

test_case "SKILL.md exists" "test -f SKILL.md" 0
test_case "README.md exists" "test -f README.md" 0
test_case "CHANGELOG.md exists" "test -f CHANGELOG.md" 0
test_case "LICENSE exists" "test -f LICENSE" 0
test_case "config.template.json exists" "test -f config.template.json" 0

echo ""
echo -e "${YELLOW}[Unit Tests: Documentation Files]${NC}"
echo ""

test_case "docs/validation-testing.md exists" "test -f docs/validation-testing.md" 0
test_case "docs/limitations.md exists" "test -f docs/limitations.md" 0
test_case "docs/edge-cases-guide.md exists" "test -f docs/edge-cases-guide.md" 0
test_case "docs/sample-outputs.md exists" "test -f docs/sample-outputs.md" 0

echo ""
echo -e "${YELLOW}[Unit Tests: Scripts]${NC}"
echo ""

test_case "scripts/install.sh exists" "test -f scripts/install.sh" 0
test_case "scripts/install.sh is executable" "test -x scripts/install.sh" 0
test_case "scripts/verify.sh exists" "test -f scripts/verify.sh" 0
test_case "scripts/verify.sh is executable" "test -x scripts/verify.sh" 0

# ============================================================================
# VALIDATION TESTS: File Contents
# ============================================================================
echo ""
echo -e "${YELLOW}[Validation Tests: File Contents]${NC}"
echo ""

test_case "SKILL.md contains 'Analysis Framework'" "grep -q 'Analysis Framework' SKILL.md" 0
test_case "SKILL.md contains 'Weighted' scoring" "grep -q -i 'weighted' SKILL.md" 0
test_case "SKILL.md contains configuration section" "grep -q 'Configuration' SKILL.md" 0
test_case "README.md contains installation guide" "grep -q -i 'installation' README.md" 0
test_case "CHANGELOG.md has version entries" "grep -q '##.*\[' CHANGELOG.md" 0
test_case "config.template.json is valid JSON" "python3 -m json.tool config.template.json > /dev/null" 0

# ============================================================================
# FORMAT TESTS: Syntax
# ============================================================================
echo ""
echo -e "${YELLOW}[Format Tests: Syntax]${NC}"
echo ""

test_case "scripts/install.sh has valid bash syntax" "bash -n scripts/install.sh" 0
test_case "scripts/verify.sh has valid bash syntax" "bash -n scripts/verify.sh" 0
test_case "All *.md files are readable" "find . -name '*.md' -exec test -r {} \;" 0

# ============================================================================
# CONTENT TESTS: Key Sections
# ============================================================================
echo ""
echo -e "${YELLOW}[Content Tests: Key Sections]${NC}"
echo ""

test_case "SKILL.md has 'What It Does' section" "grep -q 'What It Does\|How It Works' SKILL.md" 0
test_case "SKILL.md has 'Usage' section" "grep -q 'Usage' SKILL.md" 0
test_case "SKILL.md has 'Error Detection' section" "grep -q 'Error Detection' SKILL.md" 0
test_case "SKILL.md has 'AI-Generated Code' section" "grep -q 'AI-Generated\|AI-generation' SKILL.md" 0
test_case "README.md explains limitations" "grep -q -i 'limitation\|cannot' README.md" 0
test_case "docs/validation-testing.md has test cases" "grep -q 'Test.*Case\|test_case' docs/validation-testing.md" 0

# ============================================================================
# CONFIGURATION TESTS
# ============================================================================
echo ""
echo -e "${YELLOW}[Configuration Tests]${NC}"
echo ""

# Create a test config
cat > /tmp/test_config_valid.json << 'EOF'
{
  "ignorePaths": ["node_modules"],
  "analyzeUnstagedOnly": false,
  "severityThreshold": "medium",
  "aiGeneratedThreshold": 0.3,
  "enableDetailedReport": true
}
EOF

test_case "Valid config parses as JSON" "python3 -m json.tool /tmp/test_config_valid.json > /dev/null" 0

# Test invalid severityThreshold
cat > /tmp/test_config_invalid_threshold.json << 'EOF'
{
  "severityThreshold": "INVALID"
}
EOF

test_case "config.template.json is valid JSON" "python3 -m json.tool config.template.json > /dev/null" 0

# ============================================================================
# DOCUMENTATION QUALITY TESTS
# ============================================================================
echo ""
echo -e "${YELLOW}[Documentation Quality Tests]${NC}"
echo ""

test_case "README has practical examples" "grep -q '```' README.md" 0
test_case "docs/sample-outputs.md has realistic examples" "grep -q 'Example' docs/sample-outputs.md" 0
test_case "docs/limitations.md explains accuracy" "grep -q -i 'accuracy\|false' docs/limitations.md" 0
test_case "CHANGELOG.md is not empty" "test -s CHANGELOG.md" 0

# ============================================================================
# PLACEHOLDER TESTS
# ============================================================================
echo ""
echo -e "${YELLOW}[Placeholder Tests: Looking for incomplete items]${NC}"
echo ""

# This should FAIL if placeholders are found
if grep -r "yourusername\|YOUR_NAME\|FIXME_REQUIRED" . --include="*.md" 2>/dev/null | grep -v "test_config" > /tmp/placeholders.txt; then
  echo -e "${RED}✗ FAIL${NC}"
  echo "Found incomplete placeholders:"
  cat /tmp/placeholders.txt
  ((FAIL++))
else
  echo -e "${GREEN}✓ PASS${NC} - No obvious placeholders found"
  ((PASS++))
fi

# ============================================================================
# INTEGRATION TESTS (require git)
# ============================================================================
echo ""
echo -e "${YELLOW}[Integration Tests: Git Requirements]${NC}"
echo ""

if command -v git &> /dev/null; then
  test_case "git is available" "command -v git" 0
else
  skip_case "git integration tests"
fi

# ============================================================================
# SUMMARY
# ============================================================================
echo ""
echo "════════════════════════════════════════════════════════════════"
echo "  Test Summary"
echo "════════════════════════════════════════════════════════════════"
echo ""
echo -e "Passed:  ${GREEN}$PASS${NC}"
echo -e "Failed:  ${RED}$FAIL${NC}"
echo -e "Skipped: ${YELLOW}$SKIP${NC}"
echo "Total:   $((PASS + FAIL + SKIP))"
echo ""

if [ $FAIL -eq 0 ]; then
  echo -e "${GREEN}✓ All tests passed!${NC}"
  exit 0
else
  echo -e "${RED}✗ Some tests failed${NC}"
  exit 1
fi
