# Conda-forge Recipe Preparation

This directory contains a local conda recipe for `productshotai-site-kit`.

The recipe uses the GitHub `v0.1.2` source archive and sha256 used in the
conda-forge staged-recipes PR.

Local checks:

```bash
conda build conda-forge/recipe
```

This recipe uses the conda-build Jinja `meta.yaml` format. `rattler-build`
does not parse this file as-is, so use `conda-build` locally or rely on
conda-forge staged-recipes CI.
