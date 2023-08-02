import transform from './transform';

describe('transform', () => {
  it('should transform the XML string', async () => {
    const xml = '<message>Hello world!</message>';
    const transformedXml = transform(xml);
    expect(await transformedXml).toMatchObject({xml: '<message>Hello world!</message>'});
  });
});
