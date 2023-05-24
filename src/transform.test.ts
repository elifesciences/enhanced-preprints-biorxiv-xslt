import transform from './transform';

describe('transform', () => {
  it('should transform the XML string', () => {
    const xml = '<message>Hello world!</message>';
    const transformedXml = transform(xml);
    expect(transformedXml).toEqual('<transformed><message>Hello world!</message></transformed>');
  });
});
