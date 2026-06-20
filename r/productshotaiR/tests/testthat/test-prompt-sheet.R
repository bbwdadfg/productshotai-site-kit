test_that("urls include workbench", {
  expect_equal(productshotai_urls()$workbench, "https://productshotai.app/#workbench")
})

test_that("metadata is normalized", {
  data <- normalize_product_metadata(data.frame(product_name = "Red Shoe"))
  expect_equal(data$product_slug, "red-shoe")
  expect_true("image_path" %in% names(data))
})

test_that("prompt sheet contains ecommerce fields", {
  sheet <- make_prompt_sheet(data.frame(product_name = "Ceramic Mug", image_path = "mug.png"))
  expect_equal(sheet$product_slug, "ceramic-mug")
  expect_match(sheet$scene_prompt, "Ceramic Mug")
  expect_equal(sheet$productshotai_workbench_url, "https://productshotai.app/#workbench")
})
