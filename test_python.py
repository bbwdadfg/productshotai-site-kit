"""Tests for productshotai_site_kit."""

import csv
import io
import json
import tempfile
import unittest
from pathlib import Path
from productshotai_site_kit import (
    BASE, BRAND, metadata, home_url, workbench_url, pricing_url, blog_url,
    about_url, contact_url, privacy_url, terms_url, refund_policy_url,
    zh_home_url, localized_url,
)
from productshotai_site_kit.cli import build_manifest, build_prompt_sheet, main, write_rows

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

class TestCliWorkflow(unittest.TestCase):
    def test_manifest_scans_product_images(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            (root / "red-shoe.jpg").write_bytes(b"fake")
            (root / "notes.txt").write_text("ignore", encoding="utf-8")

            rows = build_manifest(root)

        self.assertEqual(len(rows), 1)
        self.assertEqual(rows[0]["file_name"], "red-shoe.jpg")
        self.assertEqual(rows[0]["product_name"], "Red Shoe")
        self.assertEqual(rows[0]["product_slug"], "red-shoe")
        self.assertEqual(rows[0]["productshotai_workbench_url"], workbench_url())

    def test_prompt_sheet_uses_manifest_fields(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            (root / "ceramic_mug.png").write_bytes(b"fake")

            rows = build_prompt_sheet(root)

        self.assertEqual(rows[0]["product_slug"], "ceramic-mug")
        self.assertIn("Ceramic Mug", rows[0]["scene_prompt"])
        self.assertEqual(rows[0]["source_image"], "ceramic_mug.png")

    def test_write_rows_csv_and_json(self):
        rows = [{"product_name": "Red Shoe", "product_slug": "red-shoe"}]
        csv_stream = io.StringIO()
        json_stream = io.StringIO()

        write_rows(rows, "csv", csv_stream)
        write_rows(rows, "json", json_stream)

        self.assertEqual(list(csv.DictReader(io.StringIO(csv_stream.getvalue())))[0]["product_slug"], "red-shoe")
        self.assertEqual(json.loads(json_stream.getvalue())[0]["product_name"], "Red Shoe")

    def test_urls_command_outputs_metadata_json(self):
        stream = io.StringIO()
        original = __import__("sys").stdout
        try:
            __import__("sys").stdout = stream
            self.assertEqual(main(["urls"]), 0)
        finally:
            __import__("sys").stdout = original

        self.assertEqual(json.loads(stream.getvalue())["name"], "ProductShot AI")

if __name__ == "__main__": unittest.main()
