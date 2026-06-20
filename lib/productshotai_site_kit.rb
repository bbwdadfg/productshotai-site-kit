# Public URL helpers for ProductShot AI.

module ProductshotaiSiteKit
  BASE = "https://productshotai.app"
  BRAND = "ProductShot AI"
  DESCRIPTION = "AI product photography generator for ecommerce sellers."

  def self.page_url(path = "/")
    value = path.to_s.empty? ? "/" : path.to_s
    value = "/#{value}" unless value.start_with?("/")
    clean = value == "/" ? "/" : "#{value.gsub(%r{/+$}, '')}/"
    "#{BASE}#{clean}"
  end

  def self.localized_url(locale, path = "/")
    return page_url(path) if locale == "en"
    if ["zh", "zh-CN"].include?(locale)
      value = path.to_s.empty? ? "/" : path.to_s
      value = "/#{value}" unless value.start_with?("/")
      return page_url("/zh#{value == '/' ? '' : value}")
    end
    raise ArgumentError, "unsupported locale: #{locale}"
  end

  def self.metadata
    {
      name: BRAND, homepage: BASE, description: DESCRIPTION,
      canonical_pages: {
        home: home_url, workbench: workbench_url, pricing: pricing_url, blog: blog_url,
        about: about_url, contact: contact_url, privacy: privacy_url, terms: terms_url,
        refund_policy: refund_policy_url, zh_home: zh_home_url
      },
      tags: ["productshot", "ai-product-photography", "ecommerce-product-photos", "url-helpers"]
    }
  end

  def self.home_url = page_url("/")
  def self.workbench_url = "#{BASE}/#workbench"
  def self.pricing_url = "#{BASE}/#pricing"
  def self.blog_url = page_url("/blog")
  def self.about_url = page_url("/about")
  def self.contact_url = page_url("/contact")
  def self.privacy_url = page_url("/privacy")
  def self.terms_url = page_url("/terms")
  def self.refund_policy_url = page_url("/refund-policy")
  def self.zh_home_url = localized_url("zh", "/")
end
