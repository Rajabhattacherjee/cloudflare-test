#!/bin/bash

# Define source and target folder names
SOURCE_DIR="sub-tessell-dev/app-shared/infra-internal-1"

# Check if the source folder exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "❌ Error: The source folder '$SOURCE_DIR' does not exist. Exiting."
    exit 1
fi

# Loop through all directories that start with "sub-*"
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
            echo "✅ 'app-shared' is already present in $dir."
        else
            echo "⚠️ 'app-shared' was NOT present in $dir."

            # Ensure the target "app-shared" folder exists before copying
            mkdir -p "$TARGET_FOLDER"

            # Copy only "infra-internal-1" from sub-tessell-dev
            cp -r "$SOURCE_DIR" "$TARGET_FOLDER/"

            echo "✅ 'infra-internal-1' has been copied to $dir/app-shared."
            echo "🚀 Now, the Resource Group can be deployed for DES in $dir."

            # Navigate to the target directory and add the copied folder to Git
            if [ -d "$TARGET_FOLDER/infra-internal-1" ]; then
                git add "$TARGET_FOLDER/infra-internal-1"
                echo "📝 Changes in '$dir/app-shared/infra-internal-1' have been added to Git."
            else
                echo "❌ Error: Failed to copy 'infra-internal-1' to $dir/app-shared."
            fi
        fi
    fi
done

# Call the PowerShell script to commit and push changes
echo "🔄 Running PowerShell script to commit and push changes..."
pwsh ./commit_and_push.ps1 -commitMessage "Added infra-internal-1 to missing app-shared directories"

