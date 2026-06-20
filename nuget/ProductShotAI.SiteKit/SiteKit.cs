namespace ProductShotAI.SiteKit;

public static class SiteKit
{
    public const string Base = "https://productshotai.app";
    public const string Brand = "ProductShot AI";
    public const string Description = "AI product photography generator for ecommerce sellers.";

    public static string PageUrl(string path = "/")
    {
        var value = string.IsNullOrWhiteSpace(path) ? "/" : path;
        if (!value.StartsWith("/")) value = "/" + value;
        var clean = value == "/" ? "/" : value.TrimEnd('/') + "/";
        return Base + clean;
    }

    public static string LocalizedUrl(string locale, string path = "/") => locale switch
    {
        "en" => PageUrl(path),
        "zh" or "zh-CN" => PageUrl("/zh" + NormalizeLocalePath(path)),
        _ => throw new ArgumentException($"unsupported locale: {locale}", nameof(locale))
    };

    private static string NormalizeLocalePath(string path)
    {
        var value = string.IsNullOrWhiteSpace(path) ? "/" : path;
        if (!value.StartsWith("/")) value = "/" + value;
        return value == "/" ? "" : value;
    }

    public static string HomeUrl() => PageUrl("/");
    public static string WorkbenchUrl() => $"{Base}/#workbench";
    public static string PricingUrl() => $"{Base}/#pricing";
    public static string BlogUrl() => PageUrl("/blog");
    public static string AboutUrl() => PageUrl("/about");
    public static string ContactUrl() => PageUrl("/contact");
    public static string PrivacyUrl() => PageUrl("/privacy");
    public static string TermsUrl() => PageUrl("/terms");
    public static string RefundPolicyUrl() => PageUrl("/refund-policy");
    public static string ZhHomeUrl() => LocalizedUrl("zh", "/");
}
