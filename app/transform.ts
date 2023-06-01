import { exec } from 'child_process';
import { writeFileSync, unlinkSync, readFileSync, existsSync } from 'fs';
import { tmpdir } from 'os';
import { join } from 'path';

const transform = async (xml: string, transformScript: string = '/app/scripts/transform.sh') : Promise<{xml: string, logs: string[]}> => {
  return new Promise((resolve, reject) => {
    if (!existsSync(transformScript)) {
      resolve({xml, logs: []});
      return;
    }

    // Create a temporary file path
    const tmpFilePath = join(tmpdir(), 'temp.xml');
    // Create a temporary log file
    const logFilePath = join(tmpdir(), 'temp.log');

    // Write the inputXml to the temporary file
    writeFileSync(tmpFilePath, xml);

    exec(`${transformScript} --input-xml "${tmpFilePath}" --log "${logFilePath}"`, (error, stdout, stderr) => {
      const logs = readFileSync(logFilePath, 'utf-8').split('\n').filter(i => i !== '');
      // Remove the temporary files
      unlinkSync(tmpFilePath);
      unlinkSync(logFilePath);

      if (error) {
        console.warn(`Error: ${error.message}`);
        reject(error);
      }
      if (stderr) {
        console.warn(`stderr: ${stderr}`);
        reject(new Error(stderr));
      }
      resolve({xml: stdout, logs});
    });
  });
};

export default transform;
