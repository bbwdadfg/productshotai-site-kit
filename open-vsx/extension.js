"use strict";

const BASE = "https://productshotai.app";

function pageUrl(path) {
  const value = String(path || "/");
  const normalized = value.startsWith("/") ? value : `/${value}`;
  const clean = normalized === "/" ? "/" : `${normalized.replace(/\/+$/, "")}/`;
  return `${BASE}${clean}`;
}

function getProductShotPages() {
  return {
    home: pageUrl("/"),
    workbench: `${BASE}/#workbench`,
    pricing: `${BASE}/#pricing`,
    blog: pageUrl("/blog"),
    contact: pageUrl("/contact"),
    zhHome: pageUrl("/zh")
  };
}

function linkSummary() {
  const pages = getProductShotPages();
  return [
    `ProductShot AI: ${pages.home}`,
    `Workbench: ${pages.workbench}`,
    `Pricing: ${pages.pricing}`,
    `Blog: ${pages.blog}`,
    `Contact: ${pages.contact}`,
    `Chinese: ${pages.zhHome}`
  ].join("\n");
}

function activate(context, vscodeApi) {
  const vscode = vscodeApi || require("vscode");
  const pages = getProductShotPages();

  context.subscriptions.push(
    vscode.commands.registerCommand("productshotai.openWorkbench", () => {
      return vscode.env.openExternal(vscode.Uri.parse(pages.workbench));
    }),
    vscode.commands.registerCommand("productshotai.openBlog", () => {
      return vscode.env.openExternal(vscode.Uri.parse(pages.blog));
    }),
    vscode.commands.registerCommand("productshotai.copySiteLinks", async () => {
      await vscode.env.clipboard.writeText(linkSummary());
      return vscode.window.showInformationMessage("ProductShot AI links copied.");
    })
  );
}

function deactivate() {}

module.exports = {
  activate,
  deactivate,
  getProductShotPages,
  linkSummary,
  pageUrl
};
