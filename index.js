'use strict';

const BASE = 'https://productshotai.app';
const BRAND = 'ProductShot AI';
const DESCRIPTION = 'AI product photography generator for ecommerce sellers.';

function pageUrl(path) {
  const normalized = String(path || '/').startsWith('/') ? String(path || '/') : '/' + String(path || '/');
  const clean = normalized === '/' ? '/' : normalized.replace(/\/+$/, '') + '/';
  return BASE + clean;
}

function localizedUrl(locale, path) {
  if (locale === 'en') return pageUrl(path);
  if (locale === 'zh' || locale === 'zh-CN') {
    const normalized = String(path || '/').startsWith('/') ? String(path || '/') : '/' + String(path || '/');
    return pageUrl('/zh' + (normalized === '/' ? '/' : normalized));
  }
  throw new Error('unsupported locale: ' + locale);
}

function metadata() {
  return {
    name: BRAND,
    homepage: BASE,
    description: DESCRIPTION,
    canonicalPages: {
      home: homeUrl(),
      workbench: workbenchUrl(),
      pricing: pricingUrl(),
      blog: blogUrl(),
      about: aboutUrl(),
      contact: contactUrl(),
      privacy: privacyUrl(),
      terms: termsUrl(),
      refundPolicy: refundPolicyUrl(),
      zhHome: zhHomeUrl()
    },
    tags: ['productshot', 'ai-product-photography', 'ecommerce-product-photos', 'url-helpers']
  };
}

function homeUrl() {
  return pageUrl('/');
}

function workbenchUrl() {
  return BASE + '/#workbench';
}

function pricingUrl() {
  return BASE + '/#pricing';
}

function blogUrl() {
  return pageUrl('/blog');
}

function aboutUrl() {
  return pageUrl('/about');
}

function contactUrl() {
  return pageUrl('/contact');
}

function privacyUrl() {
  return pageUrl('/privacy');
}

function termsUrl() {
  return pageUrl('/terms');
}

function refundPolicyUrl() {
  return pageUrl('/refund-policy');
}

function zhHomeUrl() {
  return localizedUrl('zh', '/');
}

module.exports = {
  BASE,
  BRAND,
  DESCRIPTION,
  metadata,
  pageUrl,
  localizedUrl,
  homeUrl,
  workbenchUrl,
  pricingUrl,
  blogUrl,
  aboutUrl,
  contactUrl,
  privacyUrl,
  termsUrl,
  refundPolicyUrl,
  zhHomeUrl
};
