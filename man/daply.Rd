\name{daply}
\alias{daply}
\title{Split data frame, apply function, and return results in an array.}
\usage{
  daply(.data, .variables, .fun = NULL, ..., .progress =
  "none", .drop_i = TRUE, .drop_o = TRUE, .parallel =
  FALSE)
}
\arguments{
  \item{.fun}{function to apply to each piece}

  \item{...}{other arguments passed on to \code{.fun}}

  \item{.progress}{name of the progress bar to use, see
  \code{\link{create_progress_bar}}}

  \item{.data}{data frame to be processed}

  \item{.variables}{variables to split data frame by, as
  quoted variables, a formula or character vector}

  \item{.drop_i}{should combinations of variables that do
  not appear in the input data be preserved (FALSE) or
  dropped (TRUE, default)}

  \item{.parallel}{if \code{TRUE}, apply function in
  parallel, using parallel backend provided by foreach}

  \item{.drop_o}{should extra dimensions of length 1 in the
  output be dropped, simplifying the output.  Defaults to
  \code{TRUE}}
}
\value{
  if results are atomic with same type and dimensionality,
  a vector, matrix or array; otherwise, a list-array (a
  list with dimensions)
}
\description{
  For each subset of data frame, apply function then
  combine results into an array.  \code{daply} with a
  function that operates column-wise is similar to
  \code{\link{aggregate}}.
}
\section{Input}{
  This function splits data frames by variables.
}

\section{Output}{
  If there are no results, then this function will return a
  vector of length 0 (\code{vector()}).
}
\examples{
daply(baseball, .(year), nrow)

# Several different ways of summarising by variables that should not be
# included in the summary

daply(baseball[, c(2, 6:9)], .(year), mean)
daply(baseball[, 6:9], .(baseball$year), mean)
daply(baseball, .(year), function(df) mean(df[, 6:9]))
}
\references{
  Hadley Wickham (2011). The Split-Apply-Combine Strategy
  for Data Analysis. Journal of Statistical Software,
  40(1), 1-29. \url{http://www.jstatsoft.org/v40/i01/}.
}
\seealso{
  Other array output: \code{\link{aaply}},
  \code{\link{laply}}

  Other data frame input: \code{\link{ddply}},
  \code{\link{dlply}}
}
\keyword{manip}

