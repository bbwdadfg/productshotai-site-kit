"""Static checks for conditional platform artifacts."""

from pathlib import Path
import unittest


ROOT = Path(__file__).resolve().parents[1]


def read(path: str) -> str:
    return (ROOT / path).read_text(encoding="utf-8")


class PlatformArtifactTests(unittest.TestCase):
    def test_conda_recipe_describes_real_cli(self):
        meta = read("conda-forge/recipe/meta.yaml")
        self.assertIn("entry_points:", meta)
        self.assertIn("productshotai_site_kit.cli:main", meta)
        self.assertIn("product-image manifests", meta)

    def test_r_package_exports_workflow_helpers(self):
        namespace = read("r/productshotaiR/NAMESPACE")
        description = read("r/productshotaiR/DESCRIPTION")
        self.assertIn("export(make_prompt_sheet)", namespace)
        self.assertIn("export(normalize_image_manifest)", namespace)
        self.assertIn("product photo planning tables", description)

    def test_terraform_module_uses_cloudflare_r2_resource(self):
        main = read("terraform/cloudflare-productshotai-assets/main.tf")
        variables = read("terraform/cloudflare-productshotai-assets/variables.tf")
        self.assertIn('resource "cloudflare_r2_bucket" "assets"', main)
        self.assertIn("cloudflare_account_id", variables)
        self.assertIn("bucket_name", variables)

    def test_helm_chart_has_deployable_gateway(self):
        chart = read("charts/productshotai-asset-gateway/Chart.yaml")
        deployment = read("charts/productshotai-asset-gateway/templates/deployment.yaml")
        service = read("charts/productshotai-asset-gateway/templates/service.yaml")
        self.assertIn("type: application", chart)
        self.assertIn("/healthz", deployment)
        self.assertIn("kind: Service", service)

    def test_asset_gateway_serves_health_and_config(self):
        server = read("docker/asset-gateway/server.js")
        test = read("docker/asset-gateway/test.js")
        self.assertIn('req.url === "/healthz"', server)
        self.assertIn('req.url === "/config.json"', server)
        self.assertIn("ProductShot AI workbench", test)

    def test_ansible_collection_has_real_workspace_role(self):
        galaxy = read("ansible_collections/baiwei/productshotai/galaxy.yml")
        tasks = read("ansible_collections/baiwei/productshotai/roles/productshotai_workspace/tasks/main.yml")
        example = read("ansible_collections/baiwei/productshotai/examples/workspace.yml")
        self.assertIn("namespace: baiwei", galaxy)
        self.assertIn("Create ProductShot AI workflow directories", tasks)
        self.assertIn("productshotai_workspace_root", example)


if __name__ == "__main__":
    unittest.main()
