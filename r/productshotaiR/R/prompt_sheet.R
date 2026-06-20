slugify <- function(value) {
  value <- tolower(trimws(as.character(value)))
  value <- gsub("[^a-z0-9]+", "-", value)
  value <- gsub("(^-+|-+$)", "", value)
  ifelse(nzchar(value), value, "product")
}

product_name_from_file <- function(value) {
  stem <- sub("\\.[^.]*$", "", basename(as.character(value)))
  words <- unlist(strsplit(stem, "[-_[:space:]]+"))
  paste(tools::toTitleCase(words[nzchar(words)]), collapse = " ")
}

#' Normalize Product Metadata
#'
#' @param products A data frame with at least a `product_name` column.
#' @return A normalized data frame with `product_name`, `product_slug`, and optional image path.
#' @examples
#' normalize_product_metadata(data.frame(product_name = "Red Shoe"))
#' @export
normalize_product_metadata <- function(products) {
  if (!is.data.frame(products)) {
    stop("products must be a data frame", call. = FALSE)
  }
  if (!"product_name" %in% names(products)) {
    stop("products must include a product_name column", call. = FALSE)
  }

  out <- products
  out$product_name <- trimws(as.character(out$product_name))
  out$product_slug <- slugify(out$product_name)
  if (!"image_path" %in% names(out)) {
    out$image_path <- NA_character_
  }
  out
}

#' Normalize product image metadata
#'
#' @param data A data frame with a `file` column.
#' @return A data frame with file, product_slug, workbench_url, and notes.
#' @examples
#' normalize_image_manifest(data.frame(file = "Red Shoe.jpg"))
#' @export
normalize_image_manifest <- function(data) {
  if (!is.data.frame(data)) {
    stop("data must be a data frame", call. = FALSE)
  }
  if (!"file" %in% names(data)) {
    stop("data must include a file column", call. = FALSE)
  }
  product_name <- vapply(data$file, product_name_from_file, character(1))
  data.frame(
    file = as.character(data$file),
    product_name = product_name,
    product_slug = slugify(product_name),
    workbench_url = productshotai_url("workbench"),
    notes = "",
    stringsAsFactors = FALSE
  )
}

#' Build a Product Photo Prompt Sheet
#'
#' @param products A data frame with product metadata.
#' @param background_style Default background direction for generated product photos.
#' @return A data frame ready to export as a prompt planning CSV.
#' @examples
#' make_prompt_sheet(data.frame(product_name = "Red Shoe"))
#' @export
make_prompt_sheet <- function(products, background_style = "clean studio background") {
  normalized <- normalize_product_metadata(products)
  urls <- productshotai_urls()
  data.frame(
    product_name = normalized$product_name,
    product_slug = normalized$product_slug,
    image_path = normalized$image_path,
    background = background_style,
    background_style = background_style,
    scene_prompt = paste("Create a polished ecommerce product photo for", normalized$product_name),
    negative_prompt = "blurry, distorted, extra logos, unreadable text",
    productshotai_workbench_url = urls$workbench,
    stringsAsFactors = FALSE
  )
}

#' Create a prompt planning table
#'
#' @param products Character vector of product names.
#' @return A data frame suitable for CSV export.
#' @examples
#' productshotai_prompt_sheet(c("Red running shoe"))
#' @export
productshotai_prompt_sheet <- function(products) {
  make_prompt_sheet(
    data.frame(product_name = as.character(products), stringsAsFactors = FALSE),
    background_style = "white seamless background"
  )
}

#' Write a Prompt Sheet Template
#'
#' @param products A data frame with product metadata.
#' @param file Output CSV file path.
#' @return The output file path, invisibly.
#' @examples
#' tmp <- tempfile(fileext = ".csv")
#' write_prompt_template(data.frame(product_name = "Red Shoe"), tmp)
#' @export
write_prompt_template <- function(products, file) {
  sheet <- make_prompt_sheet(products)
  utils::write.csv(sheet, file, row.names = FALSE)
  invisible(file)
}
