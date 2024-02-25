#!/bin/bash

# Function to change the version in pubspec.yaml
function changeVersion() {
    local newVersion=$1
    sed -i '' "s/version: .*/version: $newVersion/g" pubspec.yaml
    echo "Version changed to: $newVersion"
}

# Usage: ./change_version.sh <new_version>
changeVersion $1