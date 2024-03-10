from PIL import ImageGrab
import pytesseract
import os

# Define the output file path
output_file_path = 'output.txt'

# Check if the output file already exists and delete it if it does
if os.path.exists(output_file_path):
    os.remove(output_file_path)

# Capture screenshot
img = ImageGrab.grab()

# Use pytesseract to extract text
text = pytesseract.image_to_string(img)

# Check if pytesseract was able to extract text
if text:
    # Write the text to a file
    with open(output_file_path, 'w') as f:
        f.write(text)
else:
    print("No text could be extracted from the screenshot.")