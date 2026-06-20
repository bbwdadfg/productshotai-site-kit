$LOAD_PATH.unshift File.expand_path('lib', __dir__)
require 'productshotai_site_kit'

passed = 0
failed = 0

def assert(condition, message, passed, failed)
  if condition
    [passed + 1, failed]
  else
    warn "FAIL: #{message}"
    [passed, failed + 1]
  end
end

passed, failed = assert(ProductshotaiSiteKit::BASE == 'https://productshotai.app', 'base', passed, failed)
passed, failed = assert(ProductshotaiSiteKit::BRAND == 'ProductShot AI', 'brand', passed, failed)
passed, failed = assert(ProductshotaiSiteKit.home_url == 'https://productshotai.app/', 'home', passed, failed)
passed, failed = assert(ProductshotaiSiteKit.workbench_url == 'https://productshotai.app/#workbench', 'workbench', passed, failed)
passed, failed = assert(ProductshotaiSiteKit.pricing_url == 'https://productshotai.app/#pricing', 'pricing', passed, failed)
passed, failed = assert(ProductshotaiSiteKit.blog_url == 'https://productshotai.app/blog/', 'blog', passed, failed)
passed, failed = assert(ProductshotaiSiteKit.localized_url('en', '/blog') == 'https://productshotai.app/blog/', 'en locale', passed, failed)
passed, failed = assert(ProductshotaiSiteKit.localized_url('zh-CN', 'blog') == 'https://productshotai.app/zh/blog/', 'zh locale', passed, failed)
passed, failed = assert(ProductshotaiSiteKit.metadata[:canonical_pages][:home] == ProductshotaiSiteKit.home_url, 'metadata', passed, failed)

begin
  ProductshotaiSiteKit.localized_url('fr', '/blog')
  passed, failed = assert(false, 'unsupported locale', passed, failed)
rescue ArgumentError
  passed, failed = assert(true, 'unsupported locale', passed, failed)
end

puts "#{passed} passed, #{failed} failed"
exit(failed.positive? ? 1 : 0)
