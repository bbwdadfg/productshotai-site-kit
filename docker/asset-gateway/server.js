const http = require("http");

const PORT = Number(process.env.PORT || 8080);
const WORKSPACE_NAME = process.env.WORKSPACE_NAME || "ProductShot AI Assets";
const ASSET_ROOT = process.env.ASSET_ROOT || "/assets";

const links = {
  home: "https://productshotai.app/",
  workbench: "https://productshotai.app/#workbench",
  pricing: "https://productshotai.app/#pricing",
  blog: "https://productshotai.app/blog/"
};

function json(res, status, body) {
  res.writeHead(status, { "content-type": "application/json; charset=utf-8" });
  res.end(JSON.stringify(body, null, 2));
}

function html(res) {
  res.writeHead(200, { "content-type": "text/html; charset=utf-8" });
  res.end(`<!doctype html>
<html lang="en">
<meta charset="utf-8">
<title>${WORKSPACE_NAME}</title>
<body>
<h1>${WORKSPACE_NAME}</h1>
<p>Asset root: ${ASSET_ROOT}</p>
<ul>
  <li><a href="${links.workbench}">ProductShot AI workbench</a></li>
  <li><a href="${links.pricing}">Pricing</a></li>
  <li><a href="${links.blog}">Blog</a></li>
</ul>
</body>
</html>`);
}

function handler(req, res) {
  if (req.url === "/healthz") {
    return json(res, 200, { ok: true });
  }
  if (req.url === "/config.json") {
    return json(res, 200, { workspaceName: WORKSPACE_NAME, assetRoot: ASSET_ROOT, links });
  }
  if (req.url === "/" || req.url === "/index.html") {
    return html(res);
  }
  return json(res, 404, { error: "not found" });
}

if (require.main === module) {
  http.createServer(handler).listen(PORT, () => {
    console.log(`productshotai-asset-gateway listening on ${PORT}`);
  });
}

module.exports = { handler, links };
