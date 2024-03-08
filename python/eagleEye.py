from PIL import ImageGrab
import pytesseract

# Capture screenshot
img = ImageGrab.grab()
# Use pytesseract to extract text
text = pytesseract.image_to_string(img)
# Write the text to a file
with open('output.txt', 'w') as f:
    f.write(text)
