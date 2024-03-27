import os
import time
import subprocess
from PIL import ImageGrab
from pytesseract import image_to_string

BASE_DIR = os.path.dirname(os.path.realpath(__file__))
SCREENSHOT_PATH = os.path.join(BASE_DIR, 'screenshot.png')
OUTPUT_PATH = os.path.join(BASE_DIR, 'output.txt')
LOG_PATH = os.path.join(BASE_DIR, 'error.log')

def log_error(message):
    with open(LOG_PATH, 'a') as f:
        f.write(f"{time.strftime('%Y-%m-%d %H:%M:%S')}: {message}\n")

print("Preparing to take screenshot in 5 seconds...")
time.sleep(5)

img = ImageGrab.grab()
img.save(SCREENSHOT_PATH)

print("Screenshot captured successfully.")

text = image_to_string(img)

if text:
    with open(OUTPUT_PATH, 'w') as f:
        f.write(text)
else:
    log_error("Failed to extract text with Tesseract.")