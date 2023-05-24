import express from 'express';
import bodyParser from 'body-parser';
import transform from './transform';

const app = express();
app.use(bodyParser.text({type: '*/*'}));

app.post('/', async (req, res) => {
  try {
    const xmlData = req.body;
    if (typeof xmlData !== 'string') {
      throw new Error('request body should be a string');
    }
    const response = {
      xml: transform(xmlData),
      logs: []
    };
    res.json(response);
  } catch (error) {
    res.status(500).json({ error: JSON.stringify(error) });
  }
});

export default app;
