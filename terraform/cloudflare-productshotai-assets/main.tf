resource "cloudflare_r2_bucket" "assets" {
  account_id = var.cloudflare_account_id
  name       = var.bucket_name
  location   = var.location
}

locals {
  productshotai_links = {
    homepage  = "https://productshotai.app/"
    workbench = "https://productshotai.app/#workbench"
    pricing   = "https://productshotai.app/#pricing"
    docs      = "https://github.com/bbwdadfg/productshotai-site-kit"
  }
}
