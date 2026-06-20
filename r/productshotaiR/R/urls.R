base_url <- "https://productshotai.app"

#' ProductShot AI Public URLs
#'
#' @return A named list of public ProductShot AI URLs.
#' @examples
#' productshotai_urls()$workbench
#' @export
productshotai_urls <- function() {
  list(
    home = paste0(base_url, "/"),
    workbench = paste0(base_url, "/#workbench"),
    pricing = paste0(base_url, "/#pricing"),
    blog = paste0(base_url, "/blog/"),
    contact = paste0(base_url, "/contact/"),
    privacy = paste0(base_url, "/privacy/"),
    terms = paste0(base_url, "/terms/")
  )
}

#' Build a ProductShot AI public URL
#'
#' @param page One of `home`, `workbench`, `pricing`, `blog`, `contact`, `privacy`, `terms`, `refund_policy`, or `zh_home`.
#' @return A URL string.
#' @examples
#' productshotai_url("workbench")
#' @export
productshotai_url <- function(page = "home") {
  urls <- productshotai_urls()
  urls$refund_policy <- paste0(base_url, "/refund-policy/")
  urls$zh_home <- paste0(base_url, "/zh/")
  if (!page %in% names(urls)) {
    stop("unsupported ProductShot AI page: ", page, call. = FALSE)
  }
  urls[[page]]
}
