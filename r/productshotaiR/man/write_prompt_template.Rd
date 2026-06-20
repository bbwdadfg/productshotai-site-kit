\name{write_prompt_template}
\alias{write_prompt_template}
\title{Write a Prompt Sheet Template}
\usage{write_prompt_template(products, file)}
\arguments{
\item{products}{A data frame with product metadata.}
\item{file}{Output CSV file path.}
}
\value{The output file path, invisibly.}
\description{Write a ProductShot AI product-photo prompt planning CSV.}
\examples{
tmp <- tempfile(fileext = ".csv")
write_prompt_template(data.frame(product_name = "Red Shoe"), tmp)
}
