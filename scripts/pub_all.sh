#!/bin/bash

DIVIDER="======================================================"

for d in customer_app merchant_app rider_app shared_assets; do
  echo -e "\n$DIVIDER"
  echo "TARGET FOLDER: $d"
  echo "$DIVIDER"
  
  cd "$d" || { echo "Warning: Folder '$d' not found. Skipping..."; continue; }

  echo "Step 1: Running 'fvm flutter clean'..."
  fvm flutter clean
  
  echo -e "\nStep 2: Running 'fvm flutter pub get'..."
  fvm flutter pub get
  
  cd ..
  
  echo -e "\nSuccessfully processed: $d"
done

echo -e "$DIVIDER"
echo "ALL DONE! All projects cleaned and updated."
echo -e "$DIVIDER"