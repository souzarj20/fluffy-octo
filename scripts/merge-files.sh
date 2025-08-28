#!/bin/bash

# merge-files.sh - A utility script for merging files in the AuthApp.ls project

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to display usage
usage() {
    echo -e "${BLUE}File Merge Utility for AuthApp.ls${NC}"
    echo "Usage: $0 [OPTION]"
    echo ""
    echo "Options:"
    echo "  config      Merge configuration files"
    echo "  preview     Preview merge operations"
    echo "  help        Display this help message"
    echo ""
    echo "Examples:"
    echo "  $0 config                    # Merge appsettings files"
    echo "  $0 preview                   # Preview merge without changes"
}

# Function to merge configuration files
merge_config() {
    echo -e "${GREEN}Merging configuration files...${NC}"
    
    local base_file="AuthApp.ls/appsettings.json"
    local dev_file="AuthApp.ls/appsettings.Development.json"
    
    if [[ ! -f "$base_file" ]]; then
        echo -e "${RED}Error: $base_file not found${NC}"
        exit 1
    fi
    
    if [[ ! -f "$dev_file" ]]; then
        echo -e "${RED}Error: $dev_file not found${NC}"
        exit 1
    fi
    
    echo -e "${BLUE}Base file: $base_file${NC}"
    echo -e "${BLUE}Dev file: $dev_file${NC}"
    
    # Use jq if available, otherwise manual merge
    if command -v jq &> /dev/null; then
        echo -e "${GREEN}Using jq for JSON merging...${NC}"
        local merged=$(jq -s '.[0] * .[1]' "$base_file" "$dev_file")
        echo -e "${YELLOW}Merged result:${NC}"
        echo "$merged" | jq .
    else
        echo -e "${YELLOW}jq not available, showing file differences:${NC}"
        echo -e "${BLUE}=== Base configuration ===${NC}"
        cat "$base_file"
        echo -e "${BLUE}=== Development configuration ===${NC}"
        cat "$dev_file"
        echo -e "${YELLOW}Note: Install jq for automatic JSON merging${NC}"
    fi
}

# Function to preview merge operations
preview_merge() {
    echo -e "${YELLOW}Preview: Configuration file merge${NC}"
    echo "This will merge the following files:"
    echo "  - AuthApp.ls/appsettings.json (base)"
    echo "  - AuthApp.ls/appsettings.Development.json (override)"
    echo ""
    
    if [[ -f "AuthApp.ls/appsettings.json" && -f "AuthApp.ls/appsettings.Development.json" ]]; then
        echo -e "${GREEN}Files exist and are ready for merging${NC}"
        
        # Show differences
        if command -v diff &> /dev/null; then
            echo -e "${BLUE}File differences:${NC}"
            diff -u AuthApp.ls/appsettings.json AuthApp.ls/appsettings.Development.json || true
        fi
    else
        echo -e "${RED}One or more configuration files are missing${NC}"
    fi
}

# Function to check prerequisites
check_prerequisites() {
    echo -e "${BLUE}Checking prerequisites...${NC}"
    
    # Check if we're in the right directory
    if [[ ! -f "AuthApp.ls.sln" ]]; then
        echo -e "${RED}Error: Not in AuthApp.ls project root directory${NC}"
        exit 1
    fi
    
    # Check for dotnet
    if ! command -v dotnet &> /dev/null; then
        echo -e "${YELLOW}Warning: dotnet CLI not found${NC}"
    else
        echo -e "${GREEN}dotnet CLI found${NC}"
    fi
    
    # Check for git
    if ! command -v git &> /dev/null; then
        echo -e "${YELLOW}Warning: git not found${NC}"
    else
        echo -e "${GREEN}git found${NC}"
    fi
    
    # Suggest useful tools
    echo -e "${BLUE}Recommended tools for merging:${NC}"
    echo "  - jq (JSON processor): sudo apt install jq"
    echo "  - diff (file comparison): usually pre-installed"
    echo "  - merge tools: git mergetool"
}

# Main script logic
main() {
    case "${1:-help}" in
        config)
            check_prerequisites
            merge_config
            ;;
        preview)
            check_prerequisites
            preview_merge
            ;;
        help)
            usage
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            usage
            exit 1
            ;;
    esac
}

# Run main function with all arguments
main "$@"