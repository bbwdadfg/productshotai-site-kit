const assert = require("assert");
const { handler, links } = require("./server");

function call(url) {
  return new Promise((resolve) => {
    const chunks = [];
    const req = { url };
    const res = {
      status: 0,
      headers: {},
      writeHead(status, headers) {
        this.status = status;
        this.headers = headers;
      },
      end(chunk) {
        if (chunk) chunks.push(Buffer.from(chunk));
        resolve({ status: this.status, body: Buffer.concat(chunks).toString("utf8") });
      }
    };
    handler(req, res);
  });
}

(async () => {
  assert.strictEqual(links.workbench, "https://productshotai.app/#workbench");
  assert.deepStrictEqual(JSON.parse((await call("/healthz")).body), { ok: true });
  const config = JSON.parse((await call("/config.json")).body);
  assert.strictEqual(config.links.home, "https://productshotai.app/");
  assert.match((await call("/")).body, /ProductShot AI workbench/);
})();
