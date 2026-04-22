#!/bin/bash

# ======================================================
# Script: Flutter Projects Cleanup & Dependency Refresh
#
# Purpose:
# Iterates through multiple Flutter project directories and:
#   1. Cleans build artifacts
#   2. Re-fetches dependencies
#
# This ensures all projects are in a consistent, fresh state.
#
# Usage:
#   chmod +x pub_all.sh
#   source ./scripts/pub_all.sh
#
# Requirements:
#   - Run from project root (must contain listed folders)
#   - FVM installed and configured
#   - Valid pubspec.yaml in each project
# ======================================================

DIVIDER="======================================================"

# List of project directories to process
for d in customer_app merchant_app rider_app shared_assets; do
  echo -e "\n$DIVIDER"
  echo "TARGET FOLDER: $d"
  echo "$DIVIDER"
  
  # Enter directory or skip if it does not exist
  cd "$d" || { 
    echo "Warning: Folder '$d' not found. Skipping..."; 
    continue; 
  }

  echo "Step 1: Cleaning Flutter build artifacts..."
  # Removes build/, .dart_tool/, and other cached files
  fvm flutter clean
  
  echo -e "\nStep 2: Fetching dependencies..."
  # Downloads dependencies defined in pubspec.yaml
  fvm flutter pub get
  
  # Return to root directory
  cd ..
  
  echo -e "\nSuccessfully processed: $d"
done

echo -e "$DIVIDER"
echo "ALL DONE! All projects cleaned and updated."
echo -e "$DIVIDER"