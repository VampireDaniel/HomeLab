#!/bin/bash

# Check if ImageMagick is installed
if ! command -v convert &> /dev/null; then
    echo "Error: ImageMagick is not installed. Please install it first."
    echo "You can install it using: brew install imagemagick"
    exit 1
fi

# Check if sips is available (macOS only)
if ! command -v sips &> /dev/null; then
    echo "Error: sips command not found. This script requires macOS."
    exit 1
fi

# Create output directory if it doesn't exist
mkdir -p converted

# Convert all HEIC files in the current directory
for file in *.HEIC *.heic; do
    if [ -f "$file" ]; then
        echo "Converting $file..."
        
        # Get the filename without extension
        filename="${file%.*}"
        
        # Convert HEIC to PNG using sips
        sips -s format png "$file" --out "converted/${filename}.png"
        
        # Resize the PNG to 1024px width using ImageMagick
        convert "converted/${filename}.png" -resize 1024x "converted/${filename}.png"
        
        echo "Converted and resized: ${filename}.png"
    fi
done

echo "Conversion complete! Check the 'converted' directory for results." 