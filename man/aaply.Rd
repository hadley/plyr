\name{aaply}
\alias{aaply}
\title{Split array, apply function, and return results in an array.}
\usage{aaply(.data, .margins, .fun, ..., .expand=TRUE, .progress="none",
    .drop=TRUE, .parallel=FALSE)}

\description{
  Split array, apply function, and return results in an array. For each
  slice of an array, apply function then combine results into an array
}

\details{
  All plyr functions use the same split-apply-combine strategy: they
  split the input into simpler pieces, apply \code{.fun} to each piece,
  and then combine the pieces into a single data structure.  This
  function splits matrices, arrays and data frames by dimensions and
  combines the result into an array. If there are no results, then this
  function will return a vector of length 0 (\code{vector()}).

  This function is very similar to \code{\link{apply}}, except that it
  will always return an array, and when the function returns >1 d data
  structures, those dimensions are added on to the highest dimensions,
  rather than the lowest dimensions.  This makes \code{aaply}
  idempotent, so that \code{apply(input, X, identity)} is equivalent to
  \code{aperm(input, X)}.
}
\keyword{manip}
\value{if results are atomic with same type and dimensionality, a vector, matrix or array; otherwise, a list-array (a list with dimensions)}
\arguments{
  \item{.data}{matrix, array or data frame to be processed}
  \item{.margins}{a vector giving the subscripts to split up \code{data} by.  1 splits up by rows, 2 by columns and c(1,2) by rows and columns, and so on for higher dimensions}
  \item{.fun}{function to apply to each piece}
  \item{...}{other arguments passed on to \code{.fun}}
  \item{.expand}{if \code{.data} is a data frame, should output be 1d 
(expand = FALSE), with an element for each row; or nd (expand = TRUE),
with a dimension for each variable.}
  \item{.progress}{name of the progress bar to use, see \code{\link{create_progress_bar}}}
  \item{.drop}{should extra dimensions of length 1 be dropped, simplifying the output.  Defaults to \code{TRUE}}
  \item{.parallel}{if \code{TRUE}, apply function in parallel, using parallel 
backend provided by foreach}
}
\examples{dim(ozone)
aaply(ozone, 1, mean)
aaply(ozone, 1, mean, .drop = FALSE)
aaply(ozone, 3, mean)
aaply(ozone, c(1,2), mean)

dim(aaply(ozone, c(1,2), mean))
dim(aaply(ozone, c(1,2), mean, .drop = FALSE)) 

aaply(ozone, 1, each(min, max))
aaply(ozone, 3, each(min, max))

standardise <- function(x) (x - min(x)) / (max(x) - min(x))
aaply(ozone, 3, standardise)
aaply(ozone, 1:2, standardise)

aaply(ozone, 1:2, diff)}
