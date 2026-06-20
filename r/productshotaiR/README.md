# productshotaiR

R helpers for preparing ecommerce product photo planning tables for ProductShot AI workflows.

## Usage

```r
library(productshotaiR)

products <- data.frame(
  product_name = c("Red Shoe", "Ceramic Mug"),
  image_path = c("red-shoe.jpg", "ceramic-mug.png")
)

sheet <- make_prompt_sheet(products)
write.csv(sheet, "productshotai-prompts.csv", row.names = FALSE)
```

Links:

- Website: <https://productshotai.app>
- Source: <https://github.com/bbwdadfg/productshotai-site-kit>
