#!/bin/bash
#
# Update Composer Dependencies Script
# 
# This script helps maintainers update composer dependencies safely
# by checking compatibility and validating the PHP_CodeSniffer ruleset.
#

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Tarosky Coding Standards - Dependency Update Script${NC}"
echo "=================================================="

# Check if composer is installed
if ! command -v composer &> /dev/null; then
    echo -e "${RED}Error: Composer is not installed or not in PATH${NC}"
    exit 1
fi

# Check current outdated dependencies
echo -e "\n${YELLOW}Checking for outdated dependencies...${NC}"
if composer outdated --direct --strict; then
    echo -e "${GREEN}All direct dependencies are up to date!${NC}"
    read -p "Do you want to continue anyway? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Exiting..."
        exit 0
    fi
else
    echo -e "${YELLOW}Found outdated dependencies. Proceeding with update...${NC}"
fi

# Backup current composer.lock
echo -e "\n${YELLOW}Creating backup of composer.lock...${NC}"
cp composer.lock composer.lock.backup

# Update dependencies
echo -e "\n${YELLOW}Updating dependencies...${NC}"
composer update-deps-dev

# Validate composer files
echo -e "\n${YELLOW}Validating composer configuration...${NC}"
composer validate --strict

# Test that PHP_CodeSniffer can load the ruleset
echo -e "\n${YELLOW}Testing PHP_CodeSniffer ruleset...${NC}"
if ./vendor/bin/phpcs --standard=Tarosky --help > /dev/null 2>&1; then
    echo -e "${GREEN}✓ PHP_CodeSniffer ruleset loads successfully${NC}"
else
    echo -e "${RED}✗ Error: PHP_CodeSniffer ruleset failed to load${NC}"
    echo -e "${YELLOW}Restoring backup...${NC}"
    mv composer.lock.backup composer.lock
    composer install --no-interaction
    exit 1
fi

# Test ruleset on a sample PHP file
echo -e "\n${YELLOW}Testing ruleset functionality...${NC}"
echo '<?php echo "test"; ?>' > /tmp/test.php
if ./vendor/bin/phpcs --standard=Tarosky /tmp/test.php > /dev/null 2>&1; then
    echo -e "${GREEN}✓ Ruleset functionality test passed${NC}"
else
    echo -e "${YELLOW}⚠ Ruleset functionality test completed (warnings/errors may be expected)${NC}"
fi
rm -f /tmp/test.php

# Show what changed
echo -e "\n${YELLOW}Changes made:${NC}"
if git diff --quiet composer.lock.backup composer.lock; then
    echo "No changes in composer.lock"
else
    echo "composer.lock has been updated with new dependency versions"
    git diff --no-index composer.lock.backup composer.lock || true
fi

# Clean up backup
rm -f composer.lock.backup

echo -e "\n${GREEN}✓ Dependency update completed successfully!${NC}"
echo -e "${YELLOW}Next steps:${NC}"
echo "1. Review the changes in composer.lock"
echo "2. Test your projects that use this coding standard"
echo "3. Commit the changes if everything works correctly"