import * as screenshot from 'screenshot-desktop'
import * as tesseract from 'tesseract.js'
import * as fs from 'fs'

// Define output paths
const screenshotPath = './screenshot.png'
const outputPath = './output.txt'

// Capture screenshot
screenshot({ filename: screenshotPath })
  .then((imgPath) => {
    // Use tesseract to extract text
    return tesseract.recognize(imgPath)
  })
  .then((result) => {
    // Write the text to a file
    fs.writeFileSync(outputPath, result.text)
  })
  .catch((error) => {
    console.error(`Failed to capture screenshot and extract text: ${error}`)
  })