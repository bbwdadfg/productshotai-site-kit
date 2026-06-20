/// Public URL helpers for ProductShot AI.
const String base = 'https://productshotai.app';
const String brand = 'ProductShot AI';
const String description = 'AI product photography generator for ecommerce sellers.';

String pageUrl([String path = '/']) {
  var value = path.isEmpty ? '/' : path;
  if (!value.startsWith('/')) value = '/$value';
  final clean = value == '/' ? '/' : '${value.replaceFirst(RegExp(r'/+$'), '')}/';
  return '$base$clean';
}

String localizedUrl(String locale, [String path = '/']) {
  if (locale == 'en') return pageUrl(path);
  if (locale == 'zh' || locale == 'zh-CN') {
    var value = path.isEmpty ? '/' : path;
    if (!value.startsWith('/')) value = '/$value';
    return pageUrl('/zh${value == '/' ? '' : value}');
  }
  throw ArgumentError('unsupported locale: $locale');
}

Map<String, Object> metadata() => {
  'name': brand,
  'homepage': base,
  'description': description,
  'canonicalPages': {
    'home': homeUrl(), 'workbench': workbenchUrl(), 'pricing': pricingUrl(), 'blog': blogUrl(),
    'about': aboutUrl(), 'contact': contactUrl(), 'privacy': privacyUrl(), 'terms': termsUrl(),
    'refundPolicy': refundPolicyUrl(), 'zhHome': zhHomeUrl(),
  },
  'tags': ['productshot', 'ai-product-photography', 'ecommerce-product-photos', 'url-helpers'],
};

String homeUrl() => pageUrl('/');
String workbenchUrl() => '$base/#workbench';
String pricingUrl() => '$base/#pricing';
String blogUrl() => pageUrl('/blog');
String aboutUrl() => pageUrl('/about');
String contactUrl() => pageUrl('/contact');
String privacyUrl() => pageUrl('/privacy');
String termsUrl() => pageUrl('/terms');
String refundPolicyUrl() => pageUrl('/refund-policy');
String zhHomeUrl() => localizedUrl('zh', '/');
