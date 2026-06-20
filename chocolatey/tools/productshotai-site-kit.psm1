$ProductShotAIBase = 'https://productshotai.app'

function Get-ProductShotAIWorkbenchUrl { return "$ProductShotAIBase/#workbench" }
function Get-ProductShotAIPricingUrl { return "$ProductShotAIBase/#pricing" }
function Get-ProductShotAIBlogUrl { return "$ProductShotAIBase/blog/" }
function Get-ProductShotAISiteMetadata {
  return @{
    Name = 'ProductShot AI'
    Homepage = $ProductShotAIBase
    Workbench = Get-ProductShotAIWorkbenchUrl
    Pricing = Get-ProductShotAIPricingUrl
    Blog = Get-ProductShotAIBlogUrl
  }
}
Export-ModuleMember -Function Get-ProductShotAIWorkbenchUrl, Get-ProductShotAIPricingUrl, Get-ProductShotAIBlogUrl, Get-ProductShotAISiteMetadata
