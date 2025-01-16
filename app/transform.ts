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

type TransformArgs = {
  xml: string,
  passthrough?: boolean,
};

type TransformResponse = {
  xml: string,
  logs?: string[],
};

const transform = async ({ xml, passthrough }: TransformArgs) : Promise<TransformResponse> => {
  return new Promise((resolve, reject) => {
    const transformScript = '/app/scripts/transform.sh';
    if (passthrough || !existsSync(transformScript)) {
      // If access to transformScript is not available then return xml unchanged.
      resolve({
        xml,
        logs: [
          'Passthrough mode!',
        ],
      });
      return;
    }

    // Create tmp folder and files
    const tmpDirPath = mkdtempSync(join(tmpdir(), 'transform-'));
    const tmpXmlPath = join(tmpDirPath, 'temp.xml');
    const tmpLogPath = join(tmpDirPath, 'temp.log');

    // Write the input xml to the temporary file
    writeFileSync(tmpXmlPath, xml);

    exec(`${transformScript} --input-xml "${tmpXmlPath}" --log "${tmpLogPath}"`, (error, stdout, stderr) => {
      if (error) {
        console.error(`Error: ${error.message}`);
        return reject('The transform script has failed. The errors have been logged.');
      }

      const logs = readFileSync(tmpLogPath, 'utf-8').split('\n').filter(i => i !== '');

      // If stderr occurs then process it as a warning and attempt to resolve.
      if (stderr) {
        console.warn(`stderr: ${stderr}`);
        // Add warning to logs of api response.
        logs.push(stderr);
      }

      // Remove the temporary files
      unlinkSync(tmpXmlPath);
      unlinkSync(tmpLogPath);
      rmdirSync(tmpDirPath);

      return resolve({xml: stdout, logs});
    });
  });
};

export default transform;
