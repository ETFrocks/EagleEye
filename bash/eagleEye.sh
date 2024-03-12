#!/bin/bash

BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Define the screenshot and output file paths
SCREENSHOT_PATH="${BASE_DIR}/screenshot.png"
OUTPUT_PATH="${BASE_DIR}/output"

# Capture screenshot
import -window root $SCREENSHOT_PATH

# Check if Tesseract is installed
if ! command -v tesseract &> /dev/null
then
    echo "Tesseract could not be found. Please install it and try again."
    exit
fi

# Use Tesseract to extract text
tesseract $SCREENSHOT_PATH $OUTPUT_PATH

xdg-open $OUTPUT_PATH
