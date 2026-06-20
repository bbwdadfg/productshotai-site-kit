"use strict";

const assert = require("assert");
const { getProductShotPages, linkSummary, pageUrl } = require("./extension");

const pages = getProductShotPages();

assert.strictEqual(pageUrl("/"), "https://productshotai.app/");
assert.strictEqual(pages.workbench, "https://productshotai.app/#workbench");
assert.strictEqual(pages.blog, "https://productshotai.app/blog/");
assert.strictEqual(pages.zhHome, "https://productshotai.app/zh/");
assert.ok(linkSummary().includes("https://productshotai.app/#pricing"));

console.log("open-vsx tests passed");
