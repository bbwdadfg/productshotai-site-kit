<?php

namespace ProductShotAI\SiteKit;

/** Public URL helpers for ProductShot AI. */
class SiteKit
{
    public const BASE = 'https://productshotai.app';
    public const BRAND = 'ProductShot AI';
    public const DESCRIPTION = 'AI product photography generator for ecommerce sellers.';

    public static function pageUrl(string $path = '/'): string
    {
        $value = $path === '' ? '/' : $path;
        if ($value[0] !== '/') { $value = '/' . $value; }
        $clean = $value === '/' ? '/' : rtrim($value, '/') . '/';
        return self::BASE . $clean;
    }

    public static function localizedUrl(string $locale, string $path = '/'): string
    {
        if ($locale === 'en') { return self::pageUrl($path); }
        if ($locale === 'zh' || $locale === 'zh-CN') {
            $value = $path === '' ? '/' : $path;
            if ($value[0] !== '/') { $value = '/' . $value; }
            return self::pageUrl('/zh' . ($value === '/' ? '' : $value));
        }
        throw new \InvalidArgumentException('unsupported locale: ' . $locale);
    }

    public static function siteMetadata(): array
    {
        return [
            'name' => self::BRAND,
            'homepage' => self::BASE,
            'description' => self::DESCRIPTION,
            'canonicalPages' => [
                'home' => self::homeUrl(),
                'workbench' => self::workbenchUrl(),
                'pricing' => self::pricingUrl(),
                'blog' => self::blogUrl(),
                'contact' => self::contactUrl(),
                'zhHome' => self::zhHomeUrl(),
            ],
            'tags' => ['productshot', 'ai-product-photography', 'ecommerce-product-photos', 'url-helpers'],
        ];
    }

    public static function homeUrl(): string { return self::pageUrl('/'); }
    public static function workbenchUrl(): string { return self::BASE . '/#workbench'; }
    public static function pricingUrl(): string { return self::BASE . '/#pricing'; }
    public static function blogUrl(): string { return self::pageUrl('/blog'); }
    public static function aboutUrl(): string { return self::pageUrl('/about'); }
    public static function contactUrl(): string { return self::pageUrl('/contact'); }
    public static function privacyUrl(): string { return self::pageUrl('/privacy'); }
    public static function termsUrl(): string { return self::pageUrl('/terms'); }
    public static function refundPolicyUrl(): string { return self::pageUrl('/refund-policy'); }
    public static function zhHomeUrl(): string { return self::localizedUrl('zh', '/'); }
}
