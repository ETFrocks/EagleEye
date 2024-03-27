import * as fs from 'fs';
import * as path from 'path';
import * as screenshot from 'screenshot-desktop';
import { createWorker } from 'tesseract.js';

const BASE_DIR = __dirname;
const SCREENSHOT_PATH = path.join(BASE_DIR, 'screenshot.png');
const OUTPUT_PATH = path.join(BASE_DIR, 'output.txt');
const LOG_PATH = path.join(BASE_DIR, 'error.log');

const logError = (message: string) => {
    const timestamp = new Date().toISOString();
    fs.appendFileSync(LOG_PATH, `${timestamp}: ${message}\n`);
};

console.log("Preparing to take screenshot in 5 seconds...");
setTimeout(async () => {
    try {
        const imgPath = await screenshot({ filename: SCREENSHOT_PATH });
        console.log("Screenshot captured successfully.");

        const worker = createWorker();
        await worker.load();
        await worker.loadLanguage('eng');
        await worker.initialize('eng');

        const { data: { text } } = await worker.recognize(imgPath);
        if (text) {
            fs.writeFileSync(OUTPUT_PATH, text);
        } else {
            logError("Failed to extract text with Tesseract.");
        }

        await worker.terminate();
    } catch (error) {
        logError(`Failed to capture screenshot and extract text: ${error}`);
    }
}, 5000);
