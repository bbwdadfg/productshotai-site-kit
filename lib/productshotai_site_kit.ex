defmodule ProductshotaiSiteKit do
  @moduledoc "Public URL helpers for ProductShot AI."

  @base "https://productshotai.app"
  @brand "ProductShot AI"
  @description "AI product photography generator for ecommerce sellers."

  def base, do: @base
  def brand, do: @brand
  def description, do: @description

  def page_url(path \\ "/") do
    value = if path in [nil, ""], do: "/", else: path
    value = if String.starts_with?(value, "/"), do: value, else: "/#{value}"
    clean = if value == "/", do: "/", else: String.trim_trailing(value, "/") <> "/"
    @base <> clean
  end

  def localized_url("en", path), do: page_url(path)
  def localized_url(locale, path) when locale in ["zh", "zh-CN"] do
    value = if path in [nil, "", "/"], do: "/", else: path
    value = if String.starts_with?(value, "/"), do: value, else: "/#{value}"
    page_url("/zh" <> if(value == "/", do: "", else: value))
  end
  def localized_url(locale, _path), do: raise(ArgumentError, "unsupported locale: #{locale}")

  def metadata do
    %{
      name: @brand, homepage: @base, description: @description,
      canonical_pages: %{home: home_url(), workbench: workbench_url(), pricing: pricing_url(), blog: blog_url(), contact: contact_url(), zh_home: zh_home_url()},
      tags: ["productshot", "ai-product-photography", "ecommerce-product-photos", "url-helpers"]
    }
  end

  def home_url, do: page_url("/")
  def workbench_url, do: "#{@base}/#workbench"
  def pricing_url, do: "#{@base}/#pricing"
  def blog_url, do: page_url("/blog")
  def about_url, do: page_url("/about")
  def contact_url, do: page_url("/contact")
  def privacy_url, do: page_url("/privacy")
  def terms_url, do: page_url("/terms")
  def refund_policy_url, do: page_url("/refund-policy")
  def zh_home_url, do: localized_url("zh", "/")
end
