#!/bin/bash
set -e

BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Define the screenshot and output file paths
SCREENSHOT_PATH="${1:-${BASE_DIR}/screenshot.png}"
OUTPUT_PATH="${2:-${BASE_DIR}/output}"
LOG_PATH="${BASE_DIR}/error.log"

# Function to log errors
log_error() {
    echo "$(date): $1" >> $LOG_PATH
}

# Add a delay of 5 seconds
echo "Preparing to take screenshot in 5 seconds..."
sleep 5

# Check if ImageMagick is installed
command -v import &> /dev/null || log_error "ImageMagick could not be found. Please install it and try again."

# Capture screenshot
import -window root $SCREENSHOT_PATH || log_error "Failed to capture screenshot."

# Check if Tesseract is installed
command -v tesseract &> /dev/null || log_error "Tesseract could not be found. Please install it and try again."

# Use Tesseract to extract text
tesseract $SCREENSHOT_PATH $OUTPUT_PATH || log_error "Failed to extract text with Tesseract."

xdg-open $OUTPUT_PATH || log_error "Failed to open output file."
