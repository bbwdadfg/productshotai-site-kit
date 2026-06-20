terraform {
  required_version = ">= 1.5.0"
}

provider "cloudflare" {}

module "productshotai_assets" {
  source = "../.."

  cloudflare_account_id = var.cloudflare_account_id
  bucket_name           = var.bucket_name
}

variable "cloudflare_account_id" {
  type = string
}

variable "bucket_name" {
  type    = string
  default = "productshotai-assets"
}

output "bucket_name" {
  value = module.productshotai_assets.bucket_name
}
