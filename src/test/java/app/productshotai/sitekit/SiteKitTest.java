package app.productshotai.sitekit;

/** Minimal test runner for the ProductShot AI Java helper. */
public final class SiteKitTest {
    public static void main(String[] args) {
        assertEquals("ProductShot AI", SiteKit.BRAND, "brand");
        assertEquals("https://productshotai.app/", SiteKit.homeUrl(), "home URL");
        assertEquals("https://productshotai.app/#workbench", SiteKit.workbenchUrl(), "workbench URL");
        assertEquals("https://productshotai.app/#pricing", SiteKit.pricingUrl(), "pricing URL");
        assertEquals("https://productshotai.app/blog/", SiteKit.blogUrl(), "blog URL");
        assertEquals("https://productshotai.app/zh/blog/", SiteKit.localizedUrl("zh-CN", "blog"), "zh URL");
        assertEquals("ProductShot AI", SiteKit.siteMetadata().get("name"), "metadata name");
        boolean threw = false;
        try { SiteKit.localizedUrl("fr", "/blog"); } catch (IllegalArgumentException expected) { threw = true; }
        assertTrue(threw, "unsupported locale throws");
    }

    private static void assertEquals(Object expected, Object actual, String label) {
        if (!expected.equals(actual)) throw new AssertionError(label + ": expected " + expected + " got " + actual);
    }

    private static void assertTrue(boolean value, String label) {
        if (!value) throw new AssertionError(label);
    }
}
