#!/bin/bash

BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Define the screenshot and output file paths
SCREENSHOT_PATH="${1:-${BASE_DIR}/screenshot.png}"
OUTPUT_PATH="${2:-${BASE_DIR}/output}"
LOG_PATH="${BASE_DIR}/error.log"

# Function to log errors
log_error() {
    echo "$(date): $1" >> $LOG_PATH
}

# Capture screenshot
import -window root $SCREENSHOT_PATH

if [ $? -ne 0 ]; then
    log_error "Failed to capture screenshot."
    echo "Failed to capture screenshot. Check error.log for more details."
    exit 1
fi

# Check if Tesseract is installed
if ! command -v tesseract &> /dev/null
then
    log_error "Tesseract could not be found. Please install it and try again."
    echo "Tesseract could not be found. Please install it and try again."
    exit 1
fi

# Use Tesseract to extract text
tesseract $SCREENSHOT_PATH $OUTPUT_PATH

if [ $? -ne 0 ]; then
    log_error "Failed to extract text with Tesseract."
    echo "Failed to extract text with Tesseract. Check error.log for more details."
    exit 1
fi

xdg-open $OUTPUT_PATH

if [ $? -ne 0 ]; then
    log_error "Failed to open output file."
    echo "Failed to open output file. Check error.log for more details."
    exit 1
fi
