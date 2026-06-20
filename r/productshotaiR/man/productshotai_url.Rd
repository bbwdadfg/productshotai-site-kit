\name{productshotai_url}
\alias{productshotai_url}
\title{Build a ProductShot AI public URL}
\usage{productshotai_url(page = "home")}
\arguments{
\item{page}{Page key. Supported values are \code{home}, \code{workbench},
\code{pricing}, \code{blog}, \code{contact}, \code{privacy}, \code{terms},
\code{refund_policy}, and \code{zh_home}.}
}
\value{A URL string.}
\description{Build a ProductShot AI public URL.}
\examples{productshotai_url("workbench")}
