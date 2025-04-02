#!/bin/bash

# Source directory (where the app-shared folder exists)
SOURCE_DIR="sub-tessell-dev/app-shared"

# Check if the source folder exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: The source folder '$SOURCE_DIR' does not exist. Exiting."
    exit 1
fi

# Loop through all directories that start with "sub-"
for dir in sub-*; do
    # Skip the source directory itself
    if [ "$dir" == "sub-tessell-dev" ]; then
        continue
    fi

    # Check if it's a directory
    if [ -d "$dir" ]; then
        TARGET_FOLDER="$dir/app-shared"

        # Check if "app-shared" exists inside the directory
        if [ -d "$TARGET_FOLDER" ]; then
            echo "'app-shared' is already present in $dir."
        else
            # Copy "app-shared" from sub-tessell-dev
            cp -r "$SOURCE_DIR" "$TARGET_FOLDER"
            echo "'app-shared' was NOT present in $dir. It has been copied from sub-tessell-dev."
        fi
    fi
done

