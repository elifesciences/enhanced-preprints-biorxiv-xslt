import transform from './transform';

describe('transform', () => {
  it('should transform the XML string', async () => {
    const xml = '<message>Hello world!</message>';
    const transformedXml = transform({ xml });
    console.log(await transformedXml);
    expect(await transformedXml).toMatchObject({xml: '<message>Hello world!</message>'});
  });
});
