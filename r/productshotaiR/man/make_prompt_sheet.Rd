\name{make_prompt_sheet}
\alias{make_prompt_sheet}
\title{Build a Product Photo Prompt Sheet}
\usage{make_prompt_sheet(products, background_style = "clean studio background")}
\arguments{
\item{products}{A data frame with product metadata.}
\item{background_style}{Default background direction for generated product photos.}
}
\value{A data frame ready to export as a prompt planning CSV.}
\description{Build a product-photo prompt planning table from ecommerce product metadata.}
\examples{
make_prompt_sheet(data.frame(product_name = "Red Shoe"))
}
