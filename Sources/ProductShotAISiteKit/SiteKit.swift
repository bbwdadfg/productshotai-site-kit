import Foundation

public enum ProductShotAISiteKit {
    public static let base = "https://productshotai.app"
    public static let brand = "ProductShot AI"
    public static let description = "AI product photography generator for ecommerce sellers."

    public static func pageUrl(_ path: String = "/") -> String {
        var value = path.isEmpty ? "/" : path
        if !value.hasPrefix("/") { value = "/" + value }
        let clean = value == "/" ? "/" : value.trimmingCharacters(in: CharacterSet(charactersIn: "/")) + "/"
        return base + clean
    }

    public static func localizedUrl(_ locale: String, _ path: String = "/") -> String {
        if locale == "en" { return pageUrl(path) }
        if locale == "zh" || locale == "zh-CN" {
            var value = path.isEmpty ? "/" : path
            if !value.hasPrefix("/") { value = "/" + value }
            return pageUrl("/zh" + (value == "/" ? "" : value))
        }
        preconditionFailure("unsupported locale: \(locale)")
    }

    public static func homeUrl() -> String { pageUrl("/") }
    public static func workbenchUrl() -> String { "\(base)/#workbench" }
    public static func pricingUrl() -> String { "\(base)/#pricing" }
    public static func blogUrl() -> String { pageUrl("/blog") }
    public static func contactUrl() -> String { pageUrl("/contact") }
    public static func zhHomeUrl() -> String { localizedUrl("zh", "/") }
}
