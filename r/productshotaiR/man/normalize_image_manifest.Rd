\name{normalize_image_manifest}
\alias{normalize_image_manifest}
\title{Normalize product image metadata}
\usage{normalize_image_manifest(data)}
\arguments{\item{data}{A data frame with a \code{file} column.}}
\value{A data frame with file, product_slug, workbench_url, and notes.}
\description{Normalize product image metadata for product-photo batch planning.}
\examples{normalize_image_manifest(data.frame(file = "Red Shoe.jpg"))}
