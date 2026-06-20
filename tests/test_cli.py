import csv
import io
import json
import tempfile
import unittest
from pathlib import Path

from productshotai_site_kit import cli


class CliTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        self.root = Path(self.tmp.name)
        (self.root / "Second Product.PNG").write_bytes(b"png")
        (self.root / "first-product.jpg").write_bytes(b"jpg")
        (self.root / ".hidden.jpg").write_bytes(b"hidden")
        hidden_dir = self.root / ".hidden"
        hidden_dir.mkdir()
        (hidden_dir / "secret-product.jpg").write_bytes(b"hidden")
        (self.root / "notes.txt").write_text("ignore", encoding="utf-8")

    def tearDown(self):
        self.tmp.cleanup()

    def test_manifest_csv_lists_supported_images_with_stable_fields(self):
        out = io.StringIO()

        code = cli.main(["manifest", str(self.root)], stdout=out)

        self.assertEqual(code, 0)
        rows = list(csv.DictReader(io.StringIO(out.getvalue())))
        self.assertEqual([row["file_name"] for row in rows], ["first-product.jpg", "Second Product.PNG"])
        self.assertEqual(rows[0]["product_slug"], "first-product")
        self.assertEqual(rows[0]["workbench_url"], "https://productshotai.app/#workbench")
        self.assertIn("notes", rows[0])

    def test_manifest_json_uses_relative_paths_for_nested_images(self):
        nested = self.root / "nested"
        nested.mkdir()
        (nested / "Hero Shot.webp").write_bytes(b"webp")
        out = io.StringIO()

        code = cli.main(["manifest", str(self.root), "--format", "json"], stdout=out)

        self.assertEqual(code, 0)
        data = json.loads(out.getvalue())
        self.assertEqual(data["image_count"], 3)
        self.assertEqual(data["images"][2]["relative_path"], "nested/Hero Shot.webp")
        self.assertEqual(data["images"][2]["product_slug"], "hero-shot")

    def test_prompt_sheet_outputs_planning_columns(self):
        out = io.StringIO()

        code = cli.main(["prompt-sheet", str(self.root)], stdout=out)

        self.assertEqual(code, 0)
        rows = list(csv.DictReader(io.StringIO(out.getvalue())))
        self.assertEqual(rows[0]["prompt"], "Clean ecommerce product photo for first product")
        self.assertEqual(rows[0]["background"], "white seamless background")
        self.assertEqual(rows[0]["output_notes"], "")

    def test_urls_outputs_metadata_json(self):
        out = io.StringIO()

        code = cli.main(["urls", "--format", "json"], stdout=out)

        self.assertEqual(code, 0)
        data = json.loads(out.getvalue())
        self.assertEqual(data["name"], "ProductShot AI")
        self.assertEqual(data["canonicalPages"]["workbench"], "https://productshotai.app/#workbench")


if __name__ == "__main__":
    unittest.main()
