\name{adply}
\alias{adply}
\title{Split array, apply function, and return results in a data frame.}
\usage{adply(.data, .margins, .fun, ..., .expand=TRUE, .progress="none",
    .parallel=FALSE)}

\description{
  Split array, apply function, and return results in a data frame. For
  each slice of an array, apply function then combine results into a
  data frame
}

\details{
  All plyr functions use the same split-apply-combine strategy: they
  split the input into simpler pieces, apply \code{.fun} to each piece,
  and then combine the pieces into a single data structure. This
  function splits matrices, arrays and data frames by dimensions and
  combines the result into a data frame. If there are no results, then
  this function will return a data frame with zero rows and columns
  (\code{data.frame()}).
}
\keyword{manip}
\value{a data frame}
\arguments{
  \item{.data}{matrix, array or data frame to be processed}
  \item{.margins}{a vector giving the subscripts to split up \code{data} by.  1 splits up by rows, 2 by columns and c(1,2) by rows and columns, and so on for higher dimensions}
  \item{.fun}{function to apply to each piece}
  \item{...}{other arguments passed on to \code{.fun}}
  \item{.expand}{if \code{.data} is a data frame, should output be 1d 
(expand = FALSE), with an element for each row; or nd (expand = TRUE),
with a dimension for each variable.}
  \item{.progress}{name of the progress bar to use, see \code{\link{create_progress_bar}}}
  \item{.parallel}{if \code{TRUE}, apply function in parallel, using parallel 
backend provided by foreach}
}
