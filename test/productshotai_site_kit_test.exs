defmodule ProductshotaiSiteKitTest do
  use ExUnit.Case

  test "builds public ProductShot URLs" do
    assert ProductshotaiSiteKit.brand() == "ProductShot AI"
    assert ProductshotaiSiteKit.home_url() == "https://productshotai.app/"
    assert ProductshotaiSiteKit.workbench_url() == "https://productshotai.app/#workbench"
    assert ProductshotaiSiteKit.pricing_url() == "https://productshotai.app/#pricing"
    assert ProductshotaiSiteKit.blog_url() == "https://productshotai.app/blog/"
    assert ProductshotaiSiteKit.zh_home_url() == "https://productshotai.app/zh/"
  end

  test "follows locale URL rules" do
    assert ProductshotaiSiteKit.localized_url("en", "/blog") == "https://productshotai.app/blog/"
    assert ProductshotaiSiteKit.localized_url("zh-CN", "blog") == "https://productshotai.app/zh/blog/"
    assert_raise ArgumentError, fn -> ProductshotaiSiteKit.localized_url("fr", "/blog") end
  end

  test "exposes metadata" do
    assert ProductshotaiSiteKit.metadata().name == "ProductShot AI"
    assert ProductshotaiSiteKit.metadata().canonical_pages.home == ProductshotaiSiteKit.home_url()
  end
end
