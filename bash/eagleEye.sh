#!/bin/bash
set -e

BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Define the screenshot and output file paths
SCREENSHOT_PATH="${1:-${BASE_DIR}/screenshot.png}"
OUTPUT_PATH="${2:-${BASE_DIR}/output}"
LOG_PATH="${BASE_DIR}/error.log"

# Define the email address for error notifications
EMAIL="user@example.com"

# Function to check if mail command is available and working
check_mail_command() {
    if ! command -v mail &> /dev/null
    then
        echo "Mail command could not be found. Please install it before running the script."
        exit 1
    fi
}

# Function to log errors
log_error() {
    echo "$(date): $1" >> $LOG_PATH
    # Send an email notification
    check_mail_command
    for i in {1..3}
    do
        echo "$(date): $1" | mail -s "Error in screenshot script" $EMAIL && break || echo "$(date): Failed to send email. Attempt $i" >> $LOG_PATH
        sleep 5
    done
}

# Function to check if sufficient disk space is available before capturing screenshot
check_disk_space_before_capture() {
    local required_space=$1
    local available_space=$(df --output=avail "$PWD" | tail -n1)
    if (( available_space < required_space )); then
        log_error "Insufficient disk space to capture screenshot. Required: $required_space, Available: $available_space"
        exit 1
    fi
}

# Add a delay of 5 seconds
echo "Preparing to take screenshot in 5 seconds..."
sleep 5

# Check if sufficient disk space is available
check_disk_space_before_capture 50000

# Capture screenshot of a specific area
echo "Please click and drag to select the area to capture."
eval $(xdotool getmouselocation --shell)
X=$X Y=$Y
xdotool mousedown 1
while xdotool getmouselocation | grep -q "button1"; do
    sleep 0.1
done
eval $(xdotool getmouselocation --shell)
import -window root -crop $((X2-X))x$((Y2-Y))+$X+$Y $SCREENSHOT_PATH || log_error "Failed to capture screenshot."

# Function to check if a package is installed
is_package_installed() {
    dpkg -s "$1" &> /dev/null
}

# Function to check if a package is available in the repositories
is_package_available() {
    apt-cache policy "$1" | grep -q Candidate
}

# Function to check if a package is up-to-date
is_package_up_to_date() {
    sudo apt-get install --only-upgrade "$1" -y &> /dev/null
}

# Function to check if the user has sudo privileges
check_sudo() {
    if ! sudo -n true 2>/dev/null; then
        log_error "User does not have sudo privileges. Exiting."
        exit 1
    fi
}

# Function to update a package
update_package() {
    if ! is_package_up_to_date $1; then
        sudo apt-get update
        sudo apt-get upgrade $1 -y
    fi
}

# Check if required packages are installed and up-to-date
REQUIRED_PACKAGES=("imagemagick" "tesseract-ocr" "xdotool" "mailutils")
for package in "${REQUIRED_PACKAGES[@]}"; do
    if ! command -v $package &> /dev/null
    then
        check_sudo
        if ! is_package_installed $package; then
            if is_package_available $package; then
                # Check if sufficient disk space is available before installing the package
                check_disk_space_before_install 50000
                log_error "$package could not be found. Installing it now."
                sudo apt-get install $package -y
            else
                log_error "$package is not available in the repositories."
                exit 1
            fi
        else
            update_package $package
        fi
    fi
done

# Capture screenshot of a specific area
echo "Please click and drag to select the area to capture."
eval $(xdotool getmouselocation --shell)
X=$X Y=$Y
xdotool mousedown 1
while xdotool getmouselocation | grep -q "button1"; do
    sleep 0.1
done
eval $(xdotool getmouselocation --shell)
import -window root -crop $((X2-X))x$((Y2-Y))+$X+$Y $SCREENSHOT_PATH || log_error "Failed to capture screenshot."

# Check if the screenshot file exists and is not empty
if [ ! -s $SCREENSHOT_PATH ]; then
    log_error "Screenshot file is empty or does not exist."
    exit 1
fi

# Use Tesseract to extract text
tesseract $SCREENSHOT_PATH $OUTPUT_PATH || log_error "Failed to extract text with Tesseract."

# Open the output file
xdg-open $OUTPUT_PATH || log_error "Failed to open output file."

# Delete the screenshot
rm $SCREENSHOT_PATH || log_error "Failed to delete screenshot."