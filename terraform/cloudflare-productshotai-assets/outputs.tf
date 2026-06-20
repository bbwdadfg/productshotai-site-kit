output "bucket_name" {
  description = "Created R2 bucket name."
  value       = cloudflare_r2_bucket.assets.name
}

output "productshotai_links" {
  description = "ProductShot AI workflow links for downstream automation."
  value       = local.productshotai_links
}

output "asset_workflow_hint" {
  description = "Suggested folder convention for teams using ProductShot AI."
  value       = "Use input/, prompts/, generated/, and approved/ prefixes in ${cloudflare_r2_bucket.assets.name}."
}
