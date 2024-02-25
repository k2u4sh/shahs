#!/bin/bash

# Function to replace package name in pubspec.yaml
function replacePackageName() {
    local newPackageName=$1
    sed -i '' "s/name: .*/name: $newPackageName/g" pubspec.yaml
}

# Usage: ./change_package_name.sh <new_package_name>
replacePackageName $1