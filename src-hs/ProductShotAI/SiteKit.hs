module ProductShotAI.SiteKit
  ( base, brand, homeUrl, workbenchUrl, pricingUrl, blogUrl, contactUrl, zhHomeUrl, localizedUrl ) where

base :: String
base = "https://productshotai.app"

brand :: String
brand = "ProductShot AI"

pageUrl :: String -> String
pageUrl "" = base ++ "/"
pageUrl "/" = base ++ "/"
pageUrl path = base ++ clean ++ "/"
  where
    withSlash = ensureLeadingSlash path
    clean = reverse (dropWhile (== '/') (reverse withSlash))

localizedUrl :: String -> String -> Either String String
localizedUrl "en" path = Right (pageUrl path)
localizedUrl "zh" path = Right (pageUrl ("/zh" ++ normalized path))
localizedUrl "zh-CN" path = Right (pageUrl ("/zh" ++ normalized path))
localizedUrl locale _ = Left ("unsupported locale: " ++ locale)

normalized :: String -> String
normalized "" = ""
normalized "/" = ""
normalized path = ensureLeadingSlash path

ensureLeadingSlash :: String -> String
ensureLeadingSlash "" = "/"
ensureLeadingSlash path@('/' : _) = path
ensureLeadingSlash path = '/' : path

homeUrl, workbenchUrl, pricingUrl, blogUrl, contactUrl, zhHomeUrl :: String
homeUrl = pageUrl "/"
workbenchUrl = base ++ "/#workbench"
pricingUrl = base ++ "/#pricing"
blogUrl = pageUrl "/blog"
contactUrl = pageUrl "/contact"
zhHomeUrl = either error id (localizedUrl "zh" "/")
