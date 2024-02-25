#!/bin/bash

# Function to generate app icons
function generateIcons() {
    local sourceImage=$1
    local outputDir=$2

    # Create output directory if it doesn't exist
    mkdir -p $outputDir

    # List of icon sizes to generate
    local sizes=("36x36" "48x48" "72x72" "96x96" "144x144" "192x192")

    # Generate icons for each size
    for size in "${sizes[@]}"; do
        outputName="$outputDir/icon_${size}.png"
        convert $sourceImage -resize $size $outputName
        echo "Generated: $outputName"
    done
}

# Usage: ./generate_icons.sh <source_image> <output_directory>
generateIcons $1 $2
