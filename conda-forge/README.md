# Conda-forge Recipe Preparation

This directory contains a local conda recipe for `productshotai-site-kit`.

The recipe uses `source.path` so maintainers can validate the strengthened Python
CLI before a new upstream release is tagged. Before opening a conda-forge
staged-recipes PR, replace `source.path` with the released PyPI or GitHub source
archive and its `sha256`.

Local checks:

```bash
conda build conda-forge/recipe
```

This recipe uses the conda-build Jinja `meta.yaml` format. `rattler-build`
does not parse this file as-is, so use `conda-build` locally or rely on
conda-forge staged-recipes CI after replacing `source.path`.
