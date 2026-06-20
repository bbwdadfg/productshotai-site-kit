"""Tests for productshotai_site_kit."""

import unittest
from productshotai_site_kit import (
    BASE, BRAND, metadata, home_url, workbench_url, pricing_url, blog_url,
    about_url, contact_url, privacy_url, terms_url, refund_policy_url,
    zh_home_url, localized_url,
)

class TestUrls(unittest.TestCase):
    def test_public_urls(self):
        self.assertEqual(BASE, "https://productshotai.app")
        self.assertEqual(BRAND, "ProductShot AI")
        self.assertEqual(home_url(), "https://productshotai.app/")
        self.assertEqual(workbench_url(), "https://productshotai.app/#workbench")
        self.assertEqual(pricing_url(), "https://productshotai.app/#pricing")
        self.assertEqual(blog_url(), "https://productshotai.app/blog/")
        self.assertEqual(about_url(), "https://productshotai.app/about/")
        self.assertEqual(contact_url(), "https://productshotai.app/contact/")
        self.assertEqual(privacy_url(), "https://productshotai.app/privacy/")
        self.assertEqual(terms_url(), "https://productshotai.app/terms/")
        self.assertEqual(refund_policy_url(), "https://productshotai.app/refund-policy/")
        self.assertEqual(zh_home_url(), "https://productshotai.app/zh/")

    def test_locale_rules(self):
        self.assertEqual(localized_url("en", "/blog"), "https://productshotai.app/blog/")
        self.assertEqual(localized_url("zh", "/blog"), "https://productshotai.app/zh/blog/")
        self.assertEqual(localized_url("zh-CN", "contact"), "https://productshotai.app/zh/contact/")
        with self.assertRaises(ValueError): localized_url("fr", "/blog")

    def test_metadata(self):
        data = metadata()
        self.assertEqual(data["name"], "ProductShot AI")
        self.assertEqual(data["homepage"], BASE)
        self.assertEqual(data["canonicalPages"]["home"], home_url())
        self.assertIn("ai-product-photography", data["tags"])

if __name__ == "__main__": unittest.main()
