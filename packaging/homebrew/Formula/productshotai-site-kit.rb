class ProductshotaiSiteKit < Formula
  desc "ProductShot AI public URL helper CLI"
  homepage "https://productshotai.app"
  url "https://github.com/bbwdadfg/productshotai-site-kit/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "be3852270d29e0aeea849f4043be7ed5e00fa3fa6a1c3003c18875b6a16b4438"
  license "MIT"

  def install
    bin.install "bin/productshotai-site-kit"
  end

  test do
    assert_equal "https://productshotai.app/", shell_output("#{bin}/productshotai-site-kit home").strip
    assert_match "ProductShot AI", shell_output("#{bin}/productshotai-site-kit metadata")
  end
end
