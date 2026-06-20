# Conditional Platform Prep Status

Date: 2026-06-20

No live submissions were attempted for Conda-forge, CRAN, Terraform Registry,
Helm/Artifact Hub, or Ansible Galaxy. This file records repository-side
readiness only.

## Prepared Artifacts

| Platform | Local artifact | Status |
| --- | --- | --- |
| Conda-forge | `conda-forge/recipe/meta.yaml` | Prepared, but not dry-run passed. Python build/tests pass; `rattler-build` rejects the conda-build Jinja `meta.yaml`, so final validation should happen through `conda-build` or conda-forge staged-recipes CI after replacing local `source.path` with a released URL and sha256. |
| CRAN | `r/productshotaiR/` | Dry-run passed. `R CMD build` and `R CMD check --as-cran` pass with 0 ERROR, 0 WARNING, and 2 NOTE. |
| Terraform Registry | `terraform/cloudflare-productshotai-assets/` | Dry-run passed. `terraform fmt -check -recursive`, `terraform init -backend=false`, and `terraform validate` pass. Live registry listing still needs a separate public module repo and semver tag. |
| Helm / Artifact Hub | `docker/asset-gateway/`, `charts/productshotai-asset-gateway/` | Dry-run passed. Asset gateway tests, `helm lint`, and `helm template` pass. Live listing still needs a published image and chart repository/index. |
| Ansible Galaxy | `ansible_collections/baiwei/productshotai/` | Dry-run passed. `ansible-galaxy collection build` and the example workspace playbook in local check mode pass. Live publishing still needs Galaxy namespace/token confirmation. |

## Commands Tried

```bash
PYTHONDONTWRITEBYTECODE=1 python3 -m unittest discover
/tmp/productshotai-site-kit-venv/bin/coverage run -m unittest discover
/tmp/productshotai-site-kit-venv/bin/coverage report --fail-under=90
/tmp/productshotai-site-kit-venv/bin/python -m build
npm test
npm test --prefix docker/asset-gateway
R CMD build r/productshotaiR
R CMD check --as-cran productshotaiR_0.1.0.tar.gz
terraform -chdir=terraform/cloudflare-productshotai-assets fmt -check -recursive
terraform -chdir=terraform/cloudflare-productshotai-assets init -backend=false
terraform -chdir=terraform/cloudflare-productshotai-assets validate
helm lint charts/productshotai-asset-gateway
helm template productshotai-asset-gateway charts/productshotai-asset-gateway
ansible-galaxy collection build ansible_collections/baiwei/productshotai --force
ansible-playbook -i localhost, -c local ansible_collections/baiwei/productshotai/examples/workspace.yml --check
rattler-build build -r conda-forge/recipe/meta.yaml
git diff --check
```

Expected exception: `rattler-build` currently fails because this recipe uses
conda-build Jinja syntax. That is recorded as a Conda-forge preparation blocker,
not a failure of the Python package itself.
