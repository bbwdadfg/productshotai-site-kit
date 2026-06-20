test_that("urls are stable", {
  expect_equal(productshotai_url("workbench"), "https://productshotai.app/#workbench")
  expect_error(productshotai_url("missing"), "unsupported")
})

test_that("image manifests normalize file names", {
  manifest <- normalize_image_manifest(data.frame(file = c("Red Shoe.jpg")))
  expect_equal(manifest$product_slug, "red-shoe")
  expect_equal(manifest$workbench_url, "https://productshotai.app/#workbench")
})

test_that("prompt sheets contain planning columns", {
  sheet <- productshotai_prompt_sheet(c("Ceramic mug"))
  expect_equal(sheet$product_slug, "ceramic-mug")
  expect_equal(sheet$background, "white seamless background")
})
