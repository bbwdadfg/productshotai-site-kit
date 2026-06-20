# productshotai-asset-gateway

Helm chart for deploying a tiny ProductShot AI asset workflow status gateway.

The container exposes:

- `/` static workspace page
- `/config.json` machine-readable ProductShot AI links and asset root
- `/healthz` liveness/readiness endpoint

## Install

Build and publish the gateway image first, then set `image.repository` to that
published image. The default image is an explicit placeholder and is not
expected to pull until you replace `YOUR_ORG`.

```bash
helm install productshotai-asset-gateway charts/productshotai-asset-gateway \
  --set image.repository=ghcr.io/YOUR_ORG/productshotai-asset-gateway \
  --set image.tag=0.1.0
```

Set `workspace.assetRoot` to the shared product-image folder or object-store
mount used by your team.
