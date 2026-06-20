<?php
/**
 * Plugin Name: ProductShot AI Site Kit
 * Plugin URI: https://productshotai.app
 * Description: Shortcodes for linking WordPress content to ProductShot AI workbench and public pages.
 * Version: 0.1.0
 * Author: ProductShot AI
 * Author URI: https://productshotai.app
 * License: MIT
 * Requires at least: 6.0
 * Requires PHP: 7.4
 *
 * @package ProductShotAISiteKit
 */

if (!defined('ABSPATH')) {
    exit;
}

const PRODUCTSHOTAI_SITE_KIT_BASE = 'https://productshotai.app';

function productshotai_site_kit_page_url($path = '/')
{
    $value = is_string($path) && $path !== '' ? $path : '/';
    $normalized = strpos($value, '/') === 0 ? $value : '/' . $value;
    $clean = $normalized === '/' ? '/' : untrailingslashit($normalized) . '/';

    return PRODUCTSHOTAI_SITE_KIT_BASE . $clean;
}

function productshotai_site_kit_pages()
{
    return array(
        'home' => productshotai_site_kit_page_url('/'),
        'workbench' => PRODUCTSHOTAI_SITE_KIT_BASE . '/#workbench',
        'pricing' => PRODUCTSHOTAI_SITE_KIT_BASE . '/#pricing',
        'blog' => productshotai_site_kit_page_url('/blog'),
        'contact' => productshotai_site_kit_page_url('/contact'),
        'zh_home' => productshotai_site_kit_page_url('/zh'),
    );
}

function productshotai_site_kit_shortcode($atts)
{
    $atts = shortcode_atts(
        array(
            'page' => 'workbench',
            'text' => 'Open ProductShot AI',
            'target' => '_blank',
        ),
        $atts,
        'productshotai_link'
    );

    $pages = productshotai_site_kit_pages();
    $page = sanitize_key($atts['page']);
    $url = isset($pages[$page]) ? $pages[$page] : $pages['workbench'];
    $target = $atts['target'] === '_self' ? '_self' : '_blank';
    $rel = $target === '_blank' ? ' rel="noopener noreferrer"' : '';

    return sprintf(
        '<a class="productshotai-site-kit-link" href="%s" target="%s"%s>%s</a>',
        esc_url($url),
        esc_attr($target),
        $rel,
        esc_html($atts['text'])
    );
}
add_shortcode('productshotai_link', 'productshotai_site_kit_shortcode');

function productshotai_site_kit_action_links($links)
{
    $links[] = sprintf(
        '<a href="%s" target="_blank" rel="noopener noreferrer">%s</a>',
        esc_url(PRODUCTSHOTAI_SITE_KIT_BASE . '/#workbench'),
        esc_html__('Workbench', 'productshotai-site-kit')
    );

    return $links;
}
add_filter('plugin_action_links_' . plugin_basename(__FILE__), 'productshotai_site_kit_action_links');
