\name{normalize_product_metadata}
\alias{normalize_product_metadata}
\title{Normalize Product Metadata}
\usage{normalize_product_metadata(products)}
\arguments{
\item{products}{A data frame with at least a \code{product_name} column.}
}
\value{A normalized data frame with \code{product_name}, \code{product_slug}, and \code{image_path}.}
\description{Normalize ecommerce product metadata for ProductShot AI prompt planning.}
\examples{
normalize_product_metadata(data.frame(product_name = "Red Shoe"))
}
