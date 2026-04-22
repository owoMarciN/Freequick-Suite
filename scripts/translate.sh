#!/bin/bash

# ======================================================
# Script: Localization Pipeline for Multiple Modules
#
# Purpose:
# Iterates over predefined modules and generates localization
# files for each one using module-specific configuration files.
#
# Workflow per module:
#   1. Copy module-specific l10n config → l10n.yaml
#   2. Run auto translation tool
#   3. Run Flutter localization code generation
#   4. Remove temporary config
#
# Usage:
#   chmod +x translate.sh
#   source ./scripts/translate.sh
#
# Requirements:
#   - Must be run from project root (where "shared_assets" exists)
#   - Requires:
#       - dart
#       - fvm (Flutter Version Manager)
#       - auto_translator package configured
# ======================================================

DIVIDER="======================================================"

# List of modules to process
MODULES=("common" "customer" "rider" "merchant")

echo -e "$DIVIDER"
echo "TARGET FOLDER: shared_assets"
echo "$DIVIDER"

# Enter shared_assets directory (contains localization configs)
cd shared_assets || { 
    echo "Error: shared_assets folder not found."; 
    exit 1; 
}

# Loop through each module
for MODULE in "${MODULES[@]}"; do
    SPECIFIC_CONFIG="l10n_$MODULE.yaml"
    
    # Check if module-specific config exists
    if [ -f "$SPECIFIC_CONFIG" ]; then
        echo -e "\n--- Processing Module: $MODULE ---"
        
        # Step 0: Replace default config with module-specific one
        # Many tools expect config file to be named "l10n.yaml"
        cp "$SPECIFIC_CONFIG" l10n.yaml
        
        echo "Step 1: Running auto translation..."
        # Runs translation tool (e.g. generates missing translations)
        dart run auto_translator
        
        echo "Step 2: Generating Flutter localization code..."
        # Generates Dart localization classes (AppLocalizations, etc.)
        fvm flutter gen-l10n
        
        # Cleanup: remove temporary config
        rm l10n.yaml
    else
        echo "Warning: $SPECIFIC_CONFIG not found, skipping."
    fi
done

# Return to project root
cd ..

echo -e "$DIVIDER"
echo "ALL DONE! All modules processed."
echo -e "$DIVIDER"