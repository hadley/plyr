\name{laply}
\alias{laply}
\title{Split list, apply function, and return results in an array.}
\usage{
  laply(.data, .fun = NULL, ..., .progress = "none", .drop
  = TRUE, .parallel = FALSE)
}
\arguments{
  \item{.fun}{function to apply to each piece}

  \item{...}{other arguments passed on to \code{.fun}}

  \item{.progress}{name of the progress bar to use, see
  \code{\link{create_progress_bar}}}

  \item{.data}{list to be processed}

  \item{.parallel}{if \code{TRUE}, apply function in
  parallel, using parallel backend provided by foreach}

  \item{.drop}{should extra dimensions of length 1 in the
  output be dropped, simplifying the output.  Defaults to
  \code{TRUE}}
}
\value{
  if results are atomic with same type and dimensionality,
  a vector, matrix or array; otherwise, a list-array (a
  list with dimensions)
}
\description{
  For each element of a list, apply function then combine
  results into an array. \code{laply} is similar in spirit
  to \code{\link{sapply}} except that it will always return
  an array, and the output is transposed with respect
  \code{sapply} - each element of the list corresponds to a
  column, not a row.
}
\section{Input}{
  This function splits lists by elements and combines the
  result into a data frame.
}

\section{Output}{
  If there are no results, then this function will return a
  vector of length 0 (\code{vector()}).
}
\examples{
laply(baseball, is.factor)
# cf
ldply(baseball, is.factor)
colwise(is.factor)(baseball)

laply(seq_len(10), identity)
laply(seq_len(10), rep, times = 4)
laply(seq_len(10), matrix, nrow = 2, ncol = 2)
}
\references{
  Hadley Wickham (2011). The Split-Apply-Combine Strategy
  for Data Analysis. Journal of Statistical Software,
  40(1), 1-29. \url{http://www.jstatsoft.org/v40/i01/}.
}
\seealso{
  Other array output: \code{\link{aaply}},
  \code{\link{daply}}

  Other list input: \code{\link{ldply}},
  \code{\link{llply}}
}
\keyword{manip}

