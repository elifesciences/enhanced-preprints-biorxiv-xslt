import express from 'express';
import bodyParser from 'body-parser';
import transform from './transform';

const app = express();
app.use(bodyParser.text({type: '*/*', limit: '50mb'}));

app.post('/', async (req, res) => {
  try {
    const xml = req.body;
    if (typeof xml !== 'string') {
      throw new Error('request body should be a string');
    }

    // Check if the X-Passthrough header is set.
    const passthrough = !!req.headers['x-passthrough'];

    // Check if the X-Blacklist header is set.
    const blacklist = req.headers['x-blacklist'] ?? '';

    const response = await transform({
      xml,
      passthrough,
      blacklist: typeof blacklist !== 'string' ? blacklist.join(',') : blacklist,
    });
    res.json(response);
  } catch (error) {
    res.status(500).json({ error });
  }
});

export default app;
