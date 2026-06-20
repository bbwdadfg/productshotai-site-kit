# terraform-cloudflare-productshotai-assets

Terraform module for creating a Cloudflare R2 bucket used to organize
ProductShot AI product-photo inputs, prompt sheets, generated images, and
approved ecommerce assets.

This module is intentionally small: it creates the bucket and exposes stable
workflow links for automation that needs to hand users back to ProductShot AI.

## Usage

```hcl
module "productshotai_assets" {
  source = "github.com/bbwdadfg/terraform-cloudflare-productshotai-assets"

  cloudflare_account_id = var.cloudflare_account_id
  bucket_name           = "productshotai-assets"
}
```

## Requirements

| Name | Version |
| --- | --- |
| terraform | >= 1.5.0 |
| cloudflare | >= 4.0 |

## Inputs

| Name | Description | Type | Default |
| --- | --- | --- | --- |
| `cloudflare_account_id` | Cloudflare account ID that owns the R2 bucket. | `string` | n/a |
| `bucket_name` | DNS-compatible R2 bucket name. | `string` | `productshotai-assets` |
| `location` | Optional R2 jurisdiction/location hint. | `string` | `""` |

## Outputs

| Name | Description |
| --- | --- |
| `bucket_name` | Created R2 bucket name. |
| `productshotai_links` | ProductShot AI workflow links. |
| `asset_workflow_hint` | Suggested object prefix convention. |
