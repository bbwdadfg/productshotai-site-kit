import { BRAND, homeUrl, workbenchUrl, pricingUrl, blogUrl, localizedUrl, metadata } from "./mod.ts";

Deno.test("builds public ProductShot URLs", () => {
  if (BRAND !== "ProductShot AI") throw new Error("bad brand");
  if (homeUrl() !== "https://productshotai.app/") throw new Error("bad home URL");
  if (workbenchUrl() !== "https://productshotai.app/#workbench") throw new Error("bad workbench URL");
  if (pricingUrl() !== "https://productshotai.app/#pricing") throw new Error("bad pricing URL");
  if (blogUrl() !== "https://productshotai.app/blog/") throw new Error("bad blog URL");
});

Deno.test("follows locale URL rules", () => {
  if (localizedUrl("en", "/blog") !== "https://productshotai.app/blog/") throw new Error("bad en URL");
  if (localizedUrl("zh-CN", "blog") !== "https://productshotai.app/zh/blog/") throw new Error("bad zh URL");
  let threw = false;
  try { localizedUrl("fr", "/blog"); } catch { threw = true; }
  if (!threw) throw new Error("expected unsupported locale error");
});

Deno.test("exposes metadata", () => {
  const data = metadata();
  if (data.name !== "ProductShot AI") throw new Error("bad metadata name");
  if (data.canonicalPages.home !== homeUrl()) throw new Error("bad metadata home");
});
