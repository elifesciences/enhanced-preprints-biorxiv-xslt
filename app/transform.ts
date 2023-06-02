import { exec } from 'child_process';
import {
  writeFileSync,
  unlinkSync,
  readFileSync,
  existsSync,
  mkdtempSync,
  rmdirSync
} from 'fs';
import { tmpdir } from 'os';
import { join } from 'path';

const transform = async (xml: string, transformScript: string = '/app/scripts/transform.sh') : Promise<{xml: string, logs?: string[]}> => {
  return new Promise((resolve, reject) => {
    if (!existsSync(transformScript)) {
      // If access to transformScript is not available then return xml unchanged.
      resolve({xml});
      return;
    }

    // Create tmp folder and files
    const tmpDirPath = mkdtempSync(join(tmpdir(), 'transform-'));
    const tmpXmlPath = join(tmpDirPath, 'temp.xml');
    const tmpLogPath = join(tmpDirPath, 'temp.log');

    // Write the input xml to the temporary file
    writeFileSync(tmpXmlPath, xml);

    exec(`${transformScript} --input-xml "${tmpXmlPath}" --log "${tmpLogPath}"`, (error, stdout, stderr) => {
      const logs = readFileSync(tmpLogPath, 'utf-8').split('\n').filter(i => i !== '');
      // Remove the temporary files
      unlinkSync(tmpXmlPath);
      unlinkSync(tmpLogPath);
      rmdirSync(tmpDirPath);

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
