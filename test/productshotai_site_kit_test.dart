import 'package:test/test.dart';
import 'package:productshotai_site_kit/productshotai_site_kit.dart';

void main() {
  test('builds public ProductShot URLs', () {
    expect(base, 'https://productshotai.app');
    expect(brand, 'ProductShot AI');
    expect(homeUrl(), 'https://productshotai.app/');
    expect(workbenchUrl(), 'https://productshotai.app/#workbench');
    expect(pricingUrl(), 'https://productshotai.app/#pricing');
    expect(blogUrl(), 'https://productshotai.app/blog/');
    expect(contactUrl(), 'https://productshotai.app/contact/');
    expect(zhHomeUrl(), 'https://productshotai.app/zh/');
  });

  test('follows locale URL rules', () {
    expect(localizedUrl('en', '/blog'), 'https://productshotai.app/blog/');
    expect(localizedUrl('zh-CN', 'blog'), 'https://productshotai.app/zh/blog/');
    expect(() => localizedUrl('fr', '/blog'), throwsArgumentError);
  });

  test('exposes metadata', () {
    final data = metadata();
    expect(data['name'], 'ProductShot AI');
    expect((data['canonicalPages'] as Map)['home'], homeUrl());
  });
}
