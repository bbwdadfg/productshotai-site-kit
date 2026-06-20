package productshotaisitekit

import "testing"

func TestPublicURLs(t *testing.T) {
	if HomeURL() != "https://productshotai.app/" { t.Fatal(HomeURL()) }
	if WorkbenchURL() != "https://productshotai.app/#workbench" { t.Fatal(WorkbenchURL()) }
	if PricingURL() != "https://productshotai.app/#pricing" { t.Fatal(PricingURL()) }
	if BlogURL() != "https://productshotai.app/blog/" { t.Fatal(BlogURL()) }
	if ContactURL() != "https://productshotai.app/contact/" { t.Fatal(ContactURL()) }
	if ZhHomeURL() != "https://productshotai.app/zh/" { t.Fatal(ZhHomeURL()) }
}

func TestLocaleRules(t *testing.T) {
	en, err := LocalizedURL("en", "/blog")
	if err != nil || en != "https://productshotai.app/blog/" { t.Fatalf("%s %v", en, err) }
	zh, err := LocalizedURL("zh-CN", "blog")
	if err != nil || zh != "https://productshotai.app/zh/blog/" { t.Fatalf("%s %v", zh, err) }
	if _, err := LocalizedURL("fr", "/blog"); err == nil { t.Fatal("expected unsupported locale error") }
}

func TestMetadata(t *testing.T) {
	data := SiteMetadata()
	if data.Name != "ProductShot AI" { t.Fatal(data.Name) }
	if data.CanonicalPages["home"] != HomeURL() { t.Fatal("bad metadata") }
}
