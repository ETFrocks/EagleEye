import * as screenshot from 'screenshot-desktop'
import * as tesseract from 'tesseract.js'

// Capture screenshot
screenshot().then((img) => {
  // Use tesseract to extract text
  tesseract.recognize(img)
    .then((result) => {
      // Write the text to a file
      require('fs').writeFileSync('output.txt', result.text)
    })
})
