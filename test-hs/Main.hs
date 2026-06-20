import ProductShotAI.SiteKit

assertEqual :: String -> String -> String -> IO ()
assertEqual got expected label = if got == expected then pure () else error (label ++ ": expected " ++ expected ++ " got " ++ got)

main :: IO ()
main = do
  assertEqual brand "ProductShot AI" "brand"
  assertEqual homeUrl "https://productshotai.app/" "home URL"
  assertEqual workbenchUrl "https://productshotai.app/#workbench" "workbench URL"
  assertEqual pricingUrl "https://productshotai.app/#pricing" "pricing URL"
  assertEqual blogUrl "https://productshotai.app/blog/" "blog URL"
  assertEqual (either error id (localizedUrl "zh-CN" "blog")) "https://productshotai.app/zh/blog/" "zh URL"
  putStrLn "haskell tests passed"
