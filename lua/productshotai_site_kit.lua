local M = {}
M.BASE = "https://productshotai.app"
M.BRAND = "ProductShot AI"
M.DESCRIPTION = "AI product photography generator for ecommerce sellers."

local function page_url(path)
  local value = path or "/"
  if value == "" then value = "/" end
  if value:sub(1, 1) ~= "/" then value = "/" .. value end
  local clean = value == "/" and "/" or value:gsub("/+$", "") .. "/"
  return M.BASE .. clean
end

function M.localized_url(locale, path)
  if locale == "en" then return page_url(path) end
  if locale == "zh" or locale == "zh-CN" then
    local value = path or "/"
    if value == "" then value = "/" end
    if value:sub(1, 1) ~= "/" then value = "/" .. value end
    return page_url("/zh" .. (value == "/" and "" or value))
  end
  error("unsupported locale: " .. tostring(locale))
end

function M.metadata()
  return {
    name = M.BRAND, homepage = M.BASE, description = M.DESCRIPTION,
    canonical_pages = { home = M.home_url(), workbench = M.workbench_url(), pricing = M.pricing_url(), blog = M.blog_url(), contact = M.contact_url(), zh_home = M.zh_home_url() },
    tags = { "productshot", "ai-product-photography", "ecommerce-product-photos", "url-helpers" }
  }
end

function M.home_url() return page_url("/") end
function M.workbench_url() return M.BASE .. "/#workbench" end
function M.pricing_url() return M.BASE .. "/#pricing" end
function M.blog_url() return page_url("/blog") end
function M.about_url() return page_url("/about") end
function M.contact_url() return page_url("/contact") end
function M.privacy_url() return page_url("/privacy") end
function M.terms_url() return page_url("/terms") end
function M.refund_policy_url() return page_url("/refund-policy") end
function M.zh_home_url() return M.localized_url("zh", "/") end

return M
