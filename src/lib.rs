//! Public URL helpers for ProductShot AI.

pub const BASE: &str = "https://productshotai.app";
pub const BRAND: &str = "ProductShot AI";
pub const DESCRIPTION: &str = "AI product photography generator for ecommerce sellers.";

pub fn page_url(path: &str) -> String {
    if path.is_empty() || path == "/" { return format!("{}/", BASE); }
    let with_slash = if path.starts_with('/') { path.to_string() } else { format!("/{}", path) };
    let trimmed = with_slash.trim_end_matches('/');
    format!("{}{}{}", BASE, trimmed, "/")
}

pub fn localized_url(locale: &str, path: &str) -> Result<String, String> {
    match locale {
        "en" => Ok(page_url(path)),
        "zh" | "zh-CN" => {
            let value = if path.is_empty() || path == "/" { "/".to_string() } else if path.starts_with('/') { path.to_string() } else { format!("/{}", path) };
            Ok(page_url(&format!("/zh{}", if value == "/" { "" } else { &value })))
        }
        _ => Err(format!("unsupported locale: {}", locale)),
    }
}

pub fn home_url() -> String { page_url("/") }
pub fn workbench_url() -> String { format!("{}/#workbench", BASE) }
pub fn pricing_url() -> String { format!("{}/#pricing", BASE) }
pub fn blog_url() -> String { page_url("/blog") }
pub fn about_url() -> String { page_url("/about") }
pub fn contact_url() -> String { page_url("/contact") }
pub fn privacy_url() -> String { page_url("/privacy") }
pub fn terms_url() -> String { page_url("/terms") }
pub fn refund_policy_url() -> String { page_url("/refund-policy") }
pub fn zh_home_url() -> String { localized_url("zh", "/").unwrap() }

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn builds_public_urls() {
        assert_eq!(BRAND, "ProductShot AI");
        assert_eq!(home_url(), "https://productshotai.app/");
        assert_eq!(workbench_url(), "https://productshotai.app/#workbench");
        assert_eq!(pricing_url(), "https://productshotai.app/#pricing");
        assert_eq!(blog_url(), "https://productshotai.app/blog/");
        assert_eq!(contact_url(), "https://productshotai.app/contact/");
        assert_eq!(zh_home_url(), "https://productshotai.app/zh/");
    }
    #[test]
    fn follows_locale_rules() {
        assert_eq!(localized_url("en", "/blog").unwrap(), "https://productshotai.app/blog/");
        assert_eq!(localized_url("zh-CN", "blog").unwrap(), "https://productshotai.app/zh/blog/");
        assert!(localized_url("fr", "/blog").is_err());
    }
}
