'use strict';

const { execFileSync } = require('child_process');

const {
  BASE,
  BRAND,
  metadata,
  homeUrl,
  workbenchUrl,
  pricingUrl,
  blogUrl,
  aboutUrl,
  contactUrl,
  privacyUrl,
  termsUrl,
  refundPolicyUrl,
  zhHomeUrl,
  localizedUrl
} = require('./index.js');

let passed = 0;
let failed = 0;

function assert(condition, msg) {
  if (condition) {
    passed++;
  } else {
    failed++;
    console.error('FAIL: ' + msg);
  }
}

assert(BASE === 'https://productshotai.app', 'BASE URL');
assert(BRAND === 'ProductShot AI', 'brand');
assert(metadata().homepage === BASE, 'metadata homepage');
assert(metadata().canonicalPages.home === 'https://productshotai.app/', 'metadata canonical home');
assert(homeUrl() === 'https://productshotai.app/', 'homeUrl');
assert(workbenchUrl() === 'https://productshotai.app/#workbench', 'workbenchUrl');
assert(pricingUrl() === 'https://productshotai.app/#pricing', 'pricingUrl');
assert(blogUrl() === 'https://productshotai.app/blog/', 'blogUrl');
assert(aboutUrl() === 'https://productshotai.app/about/', 'aboutUrl');
assert(contactUrl() === 'https://productshotai.app/contact/', 'contactUrl');
assert(privacyUrl() === 'https://productshotai.app/privacy/', 'privacyUrl');
assert(termsUrl() === 'https://productshotai.app/terms/', 'termsUrl');
assert(refundPolicyUrl() === 'https://productshotai.app/refund-policy/', 'refundPolicyUrl');
assert(zhHomeUrl() === 'https://productshotai.app/zh/', 'zhHomeUrl');
assert(localizedUrl('en', '/blog') === 'https://productshotai.app/blog/', 'English uses prefixless URLs');
assert(localizedUrl('zh', '/blog') === 'https://productshotai.app/zh/blog/', 'Chinese uses /zh prefix');
assert(localizedUrl('zh-CN', 'contact') === 'https://productshotai.app/zh/contact/', 'zh-CN aliases to /zh');

const cli = './bin/productshotai-site-kit';
assert(execFileSync(cli, ['home'], { encoding: 'utf8' }).trim() === homeUrl(), 'CLI home URL');
assert(execFileSync(cli, ['workbench'], { encoding: 'utf8' }).trim() === workbenchUrl(), 'CLI workbench URL');
assert(execFileSync(cli, ['zh-home'], { encoding: 'utf8' }).trim() === zhHomeUrl(), 'CLI zh home URL');
assert(execFileSync(cli, ['metadata'], { encoding: 'utf8' }).includes('homepage=https://productshotai.app'), 'CLI metadata');

try {
  localizedUrl('fr', '/blog');
  assert(false, 'should throw on unsupported locale');
} catch (e) {
  assert(e.message.includes('unsupported locale'), 'throws on unsupported locale');
}

console.log(passed + ' passed, ' + failed + ' failed');
process.exit(failed > 0 ? 1 : 0);
