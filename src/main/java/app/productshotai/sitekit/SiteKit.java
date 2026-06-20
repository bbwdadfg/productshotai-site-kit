package app.productshotai.sitekit;

import java.util.List;
import java.util.Map;

/** Public URL helpers and metadata for ProductShot AI. */
public final class SiteKit {
    public static final String BASE = "https://productshotai.app";
    public static final String BRAND = "ProductShot AI";
    public static final String DESCRIPTION = "AI product photography generator for ecommerce sellers.";

    private SiteKit() {}

    public static String pageUrl(String path) {
        String value = path == null || path.isEmpty() ? "/" : path;
        if (!value.startsWith("/")) value = "/" + value;
        String clean = value.equals("/") ? "/" : value.replaceAll("/+$", "") + "/";
        return BASE + clean;
    }

    public static String localizedUrl(String locale, String path) {
        if ("en".equals(locale)) return pageUrl(path);
        if ("zh".equals(locale) || "zh-CN".equals(locale)) {
            String value = path == null || path.isEmpty() ? "/" : path;
            if (!value.startsWith("/")) value = "/" + value;
            return pageUrl("/zh" + (value.equals("/") ? "" : value));
        }
        throw new IllegalArgumentException("unsupported locale: " + locale);
    }

    public static Map<String, Object> siteMetadata() {
        return Map.of(
            "name", BRAND,
            "homepage", BASE,
            "description", DESCRIPTION,
            "canonicalPages", Map.of(
                "home", homeUrl(), "workbench", workbenchUrl(), "pricing", pricingUrl(),
                "blog", blogUrl(), "contact", contactUrl(), "zhHome", zhHomeUrl()
            ),
            "tags", List.of("productshot", "ai-product-photography", "ecommerce-product-photos", "url-helpers")
        );
    }

    public static String homeUrl() { return pageUrl("/"); }
    public static String workbenchUrl() { return BASE + "/#workbench"; }
    public static String pricingUrl() { return BASE + "/#pricing"; }
    public static String blogUrl() { return pageUrl("/blog"); }
    public static String aboutUrl() { return pageUrl("/about"); }
    public static String contactUrl() { return pageUrl("/contact"); }
    public static String privacyUrl() { return pageUrl("/privacy"); }
    public static String termsUrl() { return pageUrl("/terms"); }
    public static String refundPolicyUrl() { return pageUrl("/refund-policy"); }
    public static String zhHomeUrl() { return localizedUrl("zh", "/"); }
}
