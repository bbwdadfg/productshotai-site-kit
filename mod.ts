export const BASE = "https://productshotai.app";
export const BRAND = "ProductShot AI";
export const DESCRIPTION = "AI product photography generator for ecommerce sellers.";

export function pageUrl(path = "/"): string {
  let value = path || "/";
  if (!value.startsWith("/")) value = `/${value}`;
  const clean = value === "/" ? "/" : `${value.replace(/\/+$/, "")}/`;
  return `${BASE}${clean}`;
}

export function localizedUrl(locale: string, path = "/"): string {
  if (locale === "en") return pageUrl(path);
  if (locale === "zh" || locale === "zh-CN") {
    let value = path || "/";
    if (!value.startsWith("/")) value = `/${value}`;
    return pageUrl(`/zh${value === "/" ? "" : value}`);
  }
  throw new Error(`unsupported locale: ${locale}`);
}

export type SiteMetadata = {
  name: string;
  homepage: string;
  description: string;
  canonicalPages: Record<string, string>;
  tags: string[];
};

export function metadata(): SiteMetadata {
  return {
    name: BRAND, homepage: BASE, description: DESCRIPTION,
    canonicalPages: { home: homeUrl(), workbench: workbenchUrl(), pricing: pricingUrl(), blog: blogUrl(), contact: contactUrl(), zhHome: zhHomeUrl() },
    tags: ["productshot", "ai-product-photography", "ecommerce-product-photos", "url-helpers"],
  };
}

export const homeUrl = (): string => pageUrl("/");
export const workbenchUrl = (): string => `${BASE}/#workbench`;
export const pricingUrl = (): string => `${BASE}/#pricing`;
export const blogUrl = (): string => pageUrl("/blog");
export const aboutUrl = (): string => pageUrl("/about");
export const contactUrl = (): string => pageUrl("/contact");
export const privacyUrl = (): string => pageUrl("/privacy");
export const termsUrl = (): string => pageUrl("/terms");
export const refundPolicyUrl = (): string => pageUrl("/refund-policy");
export const zhHomeUrl = (): string => localizedUrl("zh", "/");
