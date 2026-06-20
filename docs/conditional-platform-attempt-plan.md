# Conditional Platform Attempt Plan

Target site: <https://productshotai.app>

Source repo: <https://github.com/bbwdadfg/productshotai-site-kit>

Date: 2026-06-20

## Goal

Try the remaining high-authority ecosystems without submitting backlink-only artifacts. Each platform must get a small real package that a user or maintainer can understand as useful.

This plan covers:

- Conda-forge
- CRAN
- Terraform Registry
- Helm / Artifact Hub
- Ansible Galaxy

## Baseline Rule

Do not submit empty wrappers, README-only packages, or packages whose only function is to link to ProductShot AI.

Every attempted package must have:

- A real use case tied to ecommerce product photography or ProductShot AI workflows.
- Installable source code or deployable infrastructure.
- Tests or platform-native validation.
- Clear homepage/source links.
- A clean stop point if the platform reviewer signals that the package is not appropriate.

## Official References

### Conda-forge

- Adding packages: <https://conda-forge.org/docs/maintainer/adding_pkgs/>
- Staged recipes: <https://conda-forge.org/docs/maintainer/understanding_conda_forge/staged_recipes/>
- Maintainer guidelines: <https://conda-forge.org/docs/maintainer/guidelines/>
- Example recipes repository: <https://github.com/conda-forge/staged-recipes>

### CRAN

- CRAN Repository Policy: <https://cran.r-project.org/web/packages/policies.html>
- Writing R Extensions: <https://cran.r-project.org/doc/manuals/r-release/R-exts.html>
- R Packages book: <https://r-pkgs.org/>
- CRAN incoming checks page: <https://cran.r-project.org/web/checks/check_summary.html>

### Terraform Registry

- Publish modules: <https://developer.hashicorp.com/terraform/registry/modules/publish>
- Module structure: <https://developer.hashicorp.com/terraform/language/modules/develop/structure>
- Standard module requirements: <https://developer.hashicorp.com/terraform/registry/modules/publish#standard-module-structure>
- Terraform Cloud / Registry overview: <https://developer.hashicorp.com/terraform/registry>

### Helm / Artifact Hub

- Helm chart guide: <https://helm.sh/docs/topics/charts/>
- Helm chart best practices: <https://helm.sh/docs/chart_best_practices/>
- Artifact Hub Helm repositories: <https://artifacthub.io/docs/topics/repositories/helm-charts/>
- Artifact Hub repository metadata: <https://artifacthub.io/docs/topics/repositories/>

### Ansible Galaxy

- Collection structure: <https://docs.ansible.com/ansible/latest/dev_guide/developing_collections_structure.html>
- Distributing collections: <https://docs.ansible.com/ansible/latest/dev_guide/developing_collections_distributing.html>
- Galaxy user guide: <https://docs.ansible.com/ansible/latest/galaxy/user_guide.html>
- Galaxy site: <https://galaxy.ansible.com/>

## Recommended Package Concepts

| Platform | Attempt Package | Real User Value | Publish Target |
| --- | --- | --- | --- |
| Conda-forge | `productshotai-site-kit` conda recipe | Install the Python CLI/helper from conda environments | conda-forge staged-recipes PR |
| CRAN | `productshotaiR` or `productshotai.sitekit` | R helpers for product-shot metadata tables, prompt sheets, and ProductShot AI URL generation | CRAN package submission |
| Terraform Registry | `terraform-cloudflare-productshotai-assets` | Provision a Cloudflare R2/product-image asset workspace for ProductShot AI users | Terraform public module |
| Helm / Artifact Hub | `productshotai-asset-gateway` chart | Deploy a tiny product-photo asset gateway/config page for teams using Kubernetes | Public Helm repo + Artifact Hub index |
| Ansible Galaxy | `baiwei.productshotai` collection | Install/configure ProductShot AI desktop/helper tools and asset folders on managed machines | Ansible Galaxy collection |

## Phase 0: Shared Preparation

1. Keep the existing package repo as the source of truth unless a platform requires a special repository name.
2. Add a top-level `docs/` area for platform-specific rationale and screenshots.
3. Add tests before packaging:
   - Python CLI tests for Conda-forge.
   - R tests for CRAN.
   - `terraform validate` for Terraform.
   - `helm lint` and `helm template` for Helm.
   - `ansible-galaxy collection build` for Ansible.
4. Update `publish-record.json`, `publish-record.csv`, and `publish-record.md` only after each platform reaches a clear state: `dry_run_passed`, `submitted`, `verified`, `blocked_credentials`, `blocked_review`, or `failed`.

## Conda-forge Plan

### Current Risk

The existing Python package is a small URL/metadata helper. Conda-forge reviewers may reject or question it if it looks like a generic website backlink package.

### Make It Real

Add a small but useful Python CLI workflow:

- `productshotai-site-kit manifest ./images`
  - Scans a product-image folder.
  - Emits a CSV/JSON manifest with file names, product slugs, suggested ProductShot AI workbench URL, and notes columns.
- `productshotai-site-kit prompt-sheet ./images`
  - Creates a prompt-planning CSV for ecommerce product photo batches.
- `productshotai-site-kit urls`
  - Prints public ProductShot AI URLs and metadata.

This keeps the package simple but gives conda users a real CLI utility for preparing product photo batches.

### Files To Add Or Improve

- `productshotai_site_kit/cli.py`
- `tests/` or existing Python unittest coverage for CLI output.
- `pyproject.toml` console script metadata if missing.
- `conda-forge/recipe/meta.yaml` locally before PR.

### Local Validation

```bash
python3 -m unittest discover
python3 -m build
python3 -m pip install dist/*.whl
productshotai-site-kit manifest ./sample-images
```

If conda tooling is available:

```bash
conda build conda-forge/recipe
```

or:

```bash
rattler-build build -r conda-forge/recipe
```

### Publish Steps

1. Ensure the PyPI source distribution for the chosen version is public.
2. Fork `conda-forge/staged-recipes`.
3. Add `recipes/productshotai-site-kit/meta.yaml`.
4. Open PR.
5. Respond to maintainer feedback.
6. Record as `submitted` after PR opens; record as `verified` only after feedstock/package page exists.

### Stop Conditions

Stop if reviewers say the package is not suitable for conda-forge or only useful as a website link. Do not argue around policy.

## CRAN Plan

### Current Risk

There is no real R package today. CRAN is strict, so a simple URL wrapper will probably fail review.

### Make It Real

Create a small R package focused on ecommerce product-photo planning:

- Build ProductShot AI public URLs.
- Generate product-shot prompt tables from product names/categories.
- Validate and normalize product image metadata tables.
- Export CSV templates for batch planning.

Potential package name:

- `productshotaiR`
- `productshotai.sitekit`

Prefer `productshotaiR` if available because it reads naturally as an R helper. Use `productshotai.sitekit` if the first name is unavailable or too branded.

### Files To Add

Recommended location:

- `r/productshotaiR/DESCRIPTION`
- `r/productshotaiR/NAMESPACE`
- `r/productshotaiR/R/urls.R`
- `r/productshotaiR/R/prompt_sheet.R`
- `r/productshotaiR/man/*.Rd`
- `r/productshotaiR/tests/testthat/*.R`
- `r/productshotaiR/README.md`
- `r/productshotaiR/LICENSE`

### Local Validation

```bash
R CMD build r/productshotaiR
R CMD check --as-cran productshotaiR_*.tar.gz
```

If using devtools:

```r
devtools::check(args = "--as-cran")
```

### Publish Steps

1. Run `R CMD check --as-cran` with zero errors and no avoidable warnings.
2. Confirm package name availability.
3. Submit to CRAN through the CRAN submission form.
4. Reply to CRAN maintainer feedback quickly.
5. Record as `submitted` only after CRAN accepts the submission into incoming review.
6. Record as `verified` only after the CRAN package page exists.

### Stop Conditions

Stop if CRAN asks for a clearer non-promotional purpose and we cannot provide one. Do not re-submit a thin backlink package.

## Terraform Registry Plan

### Current Risk

The existing package is not infrastructure. Terraform Registry requires a real Terraform module with standard structure and a public GitHub repository.

### Make It Real

Create a Cloudflare-focused module for product image asset staging:

`terraform-cloudflare-productshotai-assets`

The module can provision:

- Cloudflare R2 bucket for generated product photos.
- CORS rules suitable for product image upload/download workflows.
- Optional custom domain wiring variables.
- Outputs for bucket name, public hostname, and suggested ProductShot AI documentation links.

This is real infrastructure for ecommerce teams organizing ProductShot AI image output.

### Repository Naming

Terraform public modules use the pattern:

```text
terraform-<provider>-<name>
```

Recommended repo:

```text
bbwdadfg/terraform-cloudflare-productshotai-assets
```

### Files To Add

In a dedicated repo or `terraform/cloudflare-productshotai-assets/` before extraction:

- `main.tf`
- `variables.tf`
- `outputs.tf`
- `README.md`
- `examples/basic/main.tf`
- `versions.tf`
- `LICENSE`

### Local Validation

```bash
terraform fmt -check -recursive
terraform init -backend=false
terraform validate
```

### Publish Steps

1. Create public GitHub repo with standard Terraform module naming.
2. Push module files.
3. Tag release `v0.1.0`.
4. Connect the repo in Terraform Registry.
5. Verify registry page and README links.

### Stop Conditions

Stop if we cannot make the Cloudflare module functional without real Cloudflare provider resources. Do not publish a variable-only module.

## Helm / Artifact Hub Plan

### Current Risk

There is no Kubernetes service today. A chart that only opens a URL is weak.

### Make It Real

Build a tiny containerized `productshotai-asset-gateway`:

- Serves a small static configuration/status page.
- Exposes ProductShot AI links for a team workspace.
- Optionally mounts a ConfigMap of product-shot workflow links and image asset locations.
- Has a healthcheck endpoint.

This is still small, but it is a real Kubernetes-deployable component.

### Files To Add

- `docker/asset-gateway/`
  - Minimal static server or Node/Go server.
  - Health endpoint.
  - Tests if applicable.
- `charts/productshotai-asset-gateway/Chart.yaml`
- `charts/productshotai-asset-gateway/values.yaml`
- `charts/productshotai-asset-gateway/templates/deployment.yaml`
- `charts/productshotai-asset-gateway/templates/service.yaml`
- `charts/productshotai-asset-gateway/templates/configmap.yaml`
- `charts/productshotai-asset-gateway/templates/ingress.yaml`
- `charts/productshotai-asset-gateway/README.md`
- `charts/productshotai-asset-gateway/artifacthub-repo.yml` or repository metadata as needed.

### Local Validation

```bash
helm lint charts/productshotai-asset-gateway
helm template productshotai-asset-gateway charts/productshotai-asset-gateway
```

If Kubernetes is available:

```bash
helm install productshotai-asset-gateway charts/productshotai-asset-gateway --dry-run --debug
```

### Publish Steps

1. Build and publish the backing image if needed.
2. Package the chart:

```bash
helm package charts/productshotai-asset-gateway
helm repo index .
```

3. Publish chart repo through GitHub Pages or OCI registry.
4. Add repository metadata for Artifact Hub.
5. Wait for Artifact Hub indexing or submit/claim the repository.
6. Verify Artifact Hub page contains homepage and source links.

### Stop Conditions

Stop if the chart is just a static link page with no deployable operational value. Do not submit a decorative chart.

## Ansible Galaxy Plan

### Current Risk

There is no current config-management use case. A collection that only links to the website is weak.

### Make It Real

Create an Ansible collection:

```text
baiwei.productshotai
```

Initial roles:

- `productshotai_desktop`
  - Installs ProductShot AI desktop package or helper CLI where supported.
  - Creates desktop entry on Linux if a desktop package exists.
- `productshotai_workspace`
  - Creates local/team folders for product image inputs, generated outputs, and prompt sheets.
  - Writes a small config file with ProductShot AI links.
- `productshotai_asset_gateway`
  - Optionally deploys the Helm chart or Docker container on a target host.

This creates a legitimate automation story: set up a product-photo workflow environment for a managed machine or team server.

### Files To Add

- `ansible_collections/baiwei/productshotai/galaxy.yml`
- `ansible_collections/baiwei/productshotai/README.md`
- `ansible_collections/baiwei/productshotai/roles/productshotai_workspace/tasks/main.yml`
- `ansible_collections/baiwei/productshotai/roles/productshotai_workspace/defaults/main.yml`
- `ansible_collections/baiwei/productshotai/roles/productshotai_desktop/tasks/main.yml`
- `ansible_collections/baiwei/productshotai/plugins/modules/productshotai_links.py` if a module is useful.
- `ansible_collections/baiwei/productshotai/LICENSE`

### Local Validation

```bash
ansible-galaxy collection build ansible_collections/baiwei/productshotai
ansible-test sanity --docker default
```

If `ansible-test` is too heavy locally, at minimum:

```bash
ansible-galaxy collection build ansible_collections/baiwei/productshotai
ansible-playbook -i localhost, -c local examples/workspace.yml --check
```

### Publish Steps

1. Create or confirm Ansible Galaxy namespace.
2. Store token in macOS Keychain service `publish-package-backlinks/ansible-galaxy-token`.
3. Build collection tarball.
4. Publish with `ansible-galaxy collection publish`.
5. Verify Galaxy page and links.

### Stop Conditions

Stop if we cannot provide a real role or module beyond writing a URL file. A Galaxy collection should automate something real.

## Suggested Execution Order

1. Terraform Registry
   - Highest chance if we build a real Cloudflare module.
   - Requires separate repo naming.
2. Ansible Galaxy
   - Reasonable if tied to desktop/helper install or asset workspace setup.
   - May need Galaxy token/namespace.
3. Helm / Artifact Hub
   - Only after we build a real containerized asset gateway.
   - Higher maintenance than Terraform/Ansible.
4. Conda-forge
   - Try after Python CLI is stronger and has a clean source distribution.
   - Review risk remains medium-high.
5. CRAN
   - Last. Requires real R package quality and careful anti-promotional wording.
   - Highest rejection risk.

## User Decisions Needed Before Implementation

1. Approve creating new platform-specific artifacts, not just metadata wrappers.
2. Decide whether Terraform gets a separate repository named `terraform-cloudflare-productshotai-assets`.
3. Decide whether to build the desktop/PWA wrapper first; it improves Ansible and desktop package legitimacy.
4. Confirm whether ProductShot AI has or will have a public API. If yes, CRAN and Conda-forge become much stronger.
5. Confirm whether Cloudflare is the preferred infrastructure target for Terraform.

## Acceptance Criteria

Each platform attempt is complete when one of these is true:

- `verified`: public page exists and contains homepage/source links.
- `submitted`: PR/submission/review queue accepted the artifact.
- `blocked_credentials`: only account/token/namespace access is missing.
- `blocked_review`: platform reviewer requested changes.
- `failed`: platform rejected the package or validation fails after diagnosis.
- `skipped_policy`: reviewer or policy makes the package unsuitable.

## Risk Notes

- Conda-forge and CRAN should not be treated as easy backlink channels. They are reviewer-led ecosystems.
- Terraform, Helm, and Ansible become plausible only when there is real deploy/configure behavior.
- If we build the PWA desktop app first, AUR, Homebrew Cask, Chocolatey, Flathub, and Ansible all become more defensible.
- If ProductShot AI exposes a real API, Conda-forge and CRAN become much more defensible as data/workflow client packages.
