import express from 'express';
import bodyParser from 'body-parser';
import transform from './transform';

const app = express();
app.use(bodyParser.text({type: '*/*', limit: '50mb'}));

app.post('/', async (req, res) => {
  try {
    const xmlData = req.body;
    if (typeof xmlData !== 'string') {
      throw new Error('request body should be a string');
    }

    // Check if the X-Passthrough header is set.
    const passthroughMode = !!req.headers['x-passthrough'];

    const response = await transform(xmlData, passthroughMode);
    res.json(response);
  } catch (error) {
    res.status(500).json({ error });
  }
});

export default app;
