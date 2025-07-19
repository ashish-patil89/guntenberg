#!/bin/bash

# Navigate to the icons directory
cd "$(dirname "$0")/assets/icons"

# Rename all files to start with lowercase
for file in [A-Z]*; do
    # Skip if no files match
    [ -e "$file" ] || continue
    
    # Get the new filename (first character to lowercase + rest of the name)
    first_char=$(echo "${file:0:1}" | tr '[:upper:]' '[:lower:]')
    newname="$first_char${file:1}"
    
    # Only rename if the new name is different
    if [ "$file" != "$newname" ]; then
        mv -- "$file" "$newname"
        echo "Renamed: $file -> $newname"
    fi
done

echo "All icons have been renamed to start with lowercase letters."
