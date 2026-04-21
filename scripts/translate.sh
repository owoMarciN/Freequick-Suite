#!/bin/bash

DIVIDER="======================================================"
MODULES=("common" "customer" "rider" "merchant")

echo -e "$DIVIDER"
echo "TARGET FOLDER: shared_assets"
echo "$DIVIDER"

cd shared_assets || { echo "Error: shared_assets folder not found."; exit 1; }

for MODULE in "${MODULES[@]}"; do
    SPECIFIC_CONFIG="l10n_$MODULE.yaml"
    
    if [ -f "$SPECIFIC_CONFIG" ]; then
        echo -e "\n--- Processing Module: $MODULE ---"
        
        # 1. Swap the specific config into the standard position
        cp "$SPECIFIC_CONFIG" l10n.yaml
        
        echo "Step 1: Running 'dart run auto_translator'..."
        # Most translation tools look for l10n.yaml by default
        dart run auto_translator
        
        echo "Step 2: Running 'fvm flutter gen-l10n'..."
        fvm flutter gen-l10n
        
        # 2. Remove the temporary config file
        rm l10n.yaml
    else
        echo "Warning: $SPECIFIC_CONFIG not found, skipping."
    fi
done

cd ..

# echo -e "\n$DIVIDER"
# echo "TARGET FOLDER: scripts"
# echo "$DIVIDER"

# if [ -f "scripts/pub_all.sh" ]; then
#     echo "Step 3: Sourcing 'pub_all.sh'..."
#     source scripts/pub_all.sh
# else
#     echo "Error: scripts/pub_all.sh not found."
# fi

echo -e "$DIVIDER"
echo "ALL DONE! All 4 modules processed."
echo -e "$DIVIDER"