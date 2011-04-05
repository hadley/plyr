\name{a_ply}
\alias{a_ply}
\title{Split array, apply function, and discard results.}
\usage{a_ply(.data, .margins, .fun, ..., .expand=TRUE,
    .progress="none", .print=FALSE)}

\description{
  Split array, apply function, and discard results. For
  each slice of an array, apply function and discard
  results
}

\details{
  All plyr functions use the same split-apply-combine
  strategy: they split the input into simpler pieces, apply
  \code{.fun} to each piece, and then combine the pieces
  into a single data structure.  This function splits
  matrices, arrays and data frames by dimensions and
  discards the output.  This is useful for functions that
  you are calling purely for their side effects like
  display plots and saving output.
}
\keyword{manip}
\references{Hadley Wickham (2011). The Split-Apply-Combine Strategy for
Data Analysis. Journal of Statistical Software, 40(1), 1-29. 
\url{http://www.jstatsoft.org/v40/i01/}.}
\arguments{
  \item{.data}{matrix, array or data frame to be processed}
  \item{.margins}{a vector giving the subscripts to split up \code{data} by.  1 splits up by rows, 2 by columns and c(1,2) by rows and columns, and so on for higher dimensions}
  \item{.fun}{function to apply to each piece}
  \item{...}{other arguments passed on to \code{.fun}}
  \item{.expand}{if \code{.data} is a data frame, should output be 1d 
(expand = FALSE), with an element for each row; or nd (expand = TRUE),
with a dimension for each variable.}
  \item{.progress}{name of the progress bar to use, see \code{\link{create_progress_bar}}}
  \item{.print}{automatically print each result? (default: \code{FALSE})}
}
