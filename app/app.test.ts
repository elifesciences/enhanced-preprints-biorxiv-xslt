// @ts-ignore
import request from 'supertest';
import app from './app';

describe('POST /', () => {
  it('should convert xml to json', async () => {
    const xml = '<root><child>content</child></root>';
    const res = await request(app).post('/').send(xml);

    expect(res.statusCode).toEqual(200);
    expect(res.body).toMatchObject({
      xml: '<root><child>content</child></root>'
    });
  });
});
