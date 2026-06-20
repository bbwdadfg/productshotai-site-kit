variable "cloudflare_account_id" {
  description = "Cloudflare account ID that owns the R2 bucket."
  type        = string
}

variable "bucket_name" {
  description = "Name for the R2 bucket used to stage ProductShot AI source and generated assets."
  type        = string
  default     = "productshotai-assets"

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9.-]{1,61}[a-z0-9]$", var.bucket_name))
    error_message = "bucket_name must be a DNS-compatible lowercase R2 bucket name."
  }
}

variable "location" {
  description = "Optional R2 jurisdiction/location hint. Use null for Cloudflare automatic placement."
  type        = string
  default     = null
  nullable    = true

  validation {
    condition     = var.location == null || contains(["apac", "eeur", "enam", "weur", "wnam"], var.location)
    error_message = "location must be null or one of: apac, eeur, enam, weur, wnam."
  }
}
