// @ts-ignore
import request from 'supertest';
import app from './app';

describe('POST /', () => {
  it('should convert xml to json and add timestamp', async () => {
    const xml = '<root><child>content</child></root>';
    const res = await request(app).post('/').send(xml);

    expect(res.statusCode).toEqual(200);
    expect(res.body).toStrictEqual({xml: '<root><child>content</child></root>', logs: []});
  });
});
