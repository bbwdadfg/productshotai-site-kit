// Package productshotaisitekit provides public ProductShot AI URL helpers.
package productshotaisitekit

import "fmt"

const Base = "https://productshotai.app"
const Brand = "ProductShot AI"
const Description = "AI product photography generator for ecommerce sellers."

type Metadata struct {
	Name string
	Homepage string
	Description string
	CanonicalPages map[string]string
	Tags []string
}

func pageURL(path string) string {
	if path == "" || path == "/" { return Base + "/" }
	if path[0] != '/' { path = "/" + path }
	for len(path) > 1 && path[len(path)-1] == '/' { path = path[:len(path)-1] }
	return Base + path + "/"
}

func LocalizedURL(locale, path string) (string, error) {
	if locale == "en" { return pageURL(path), nil }
	if locale == "zh" || locale == "zh-CN" {
		if path == "" || path == "/" { return pageURL("/zh"), nil }
		if path[0] != '/' { path = "/" + path }
		return pageURL("/zh" + path), nil
	}
	return "", fmt.Errorf("unsupported locale: %s", locale)
}

func SiteMetadata() Metadata {
	return Metadata{Brand, Base, Description, map[string]string{
		"home": HomeURL(), "workbench": WorkbenchURL(), "pricing": PricingURL(), "blog": BlogURL(),
		"about": AboutURL(), "contact": ContactURL(), "privacy": PrivacyURL(), "terms": TermsURL(),
		"refundPolicy": RefundPolicyURL(), "zhHome": ZhHomeURL(),
	}, []string{"productshot", "ai-product-photography", "ecommerce-product-photos", "url-helpers"}}
}

func HomeURL() string { return pageURL("/") }
func WorkbenchURL() string { return Base + "/#workbench" }
func PricingURL() string { return Base + "/#pricing" }
func BlogURL() string { return pageURL("/blog") }
func AboutURL() string { return pageURL("/about") }
func ContactURL() string { return pageURL("/contact") }
func PrivacyURL() string { return pageURL("/privacy") }
func TermsURL() string { return pageURL("/terms") }
func RefundPolicyURL() string { return pageURL("/refund-policy") }
func ZhHomeURL() string { u, _ := LocalizedURL("zh", "/"); return u }
