# baiwei.productshotai

Ansible collection for preparing local or team workspaces used with ProductShot AI product-photo workflows.

The initial role creates a predictable workspace layout for source images, prompt sheets, generated images, and approved ecommerce assets. It also writes a small JSON config with ProductShot AI workflow links.

## Example

```yaml
- hosts: localhost
  connection: local
  roles:
    - role: baiwei.productshotai.productshotai_workspace
      productshotai_workspace_root: /tmp/productshotai-assets
```

The optional `productshotai_asset_gateway` role writes a Compose file for the
gateway container. Set `productshotai_gateway_image` to an image you have built
and published before running that role.

Links:

- Website: <https://productshotai.app>
- Source: <https://github.com/bbwdadfg/productshotai-site-kit>
