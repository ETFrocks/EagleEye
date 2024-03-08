# EagleEye

EagleEye is an innovative internal tool that employs Optical Character Recognition (OCR) technology to convert on-screen information into editable text. This aids in data analysis and content management tasks. EagleEye captures, interprets, and transcribes, providing a seamless transition from visual data to actionable text.

The tool is implemented in three different scripts: Bash, Python, and TypeScript. Each of these scripts are located in their respective folders (bash/, python/, and typescript/).

## Bash

Bash itself doesn't have OCR capabilities, but it can be used to call other command-line tools like Tesseract, an OCR tool that can be used on Linux. The Bash script captures a screenshot and processes it with Tesseract.

## Python

Python has several libraries that can be used for OCR, such as pytesseract. The Python script uses the Pillow library to capture a screenshot and pytesseract to process it.

## TypeScript

TypeScript is a superset of JavaScript that adds static types. It's primarily used for web development, so it doesn't have direct access to system resources like a screenshot function or an OCR library. However, you can use Node.js libraries to achieve this. The TypeScript script uses the screenshot-desktop and tesseract.js libraries.

Please note that these are very basic scripts and may not work perfectly for all types of images. You may need to add image preprocessing steps (like binarization, noise removal, etc.) to improve the OCR results. Also, you'll need to handle errors and edge cases in a real-world application.

## Authors

* **BlackBird** - *Initial work* - [ETFrocks](https://github.com/ETFrocks)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to Stephen Dolan, the creator of jq, a lightweight and flexible command-line JSON processor, first released in 2013.
* Respect to Daniel Stenberg, the creator of curl, a command-line tool for transferring data with URLs, first released in 1997.
* Acknowledgment to Mark Shuttleworth, who founded Canonical Ltd., which developed and continues to maintain Ubuntu, first released in 2004.
* Salute to Linus Torvalds, the creator of Linux, the open-source operating system kernel, first released in 1991.
* A big thank you to all the creators and contributors of open-source software. Your work has made a significant impact on the world of technology.

Please note that the dates mentioned are for the initial releases of these tools and platforms.
