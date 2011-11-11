\name{mlply}
\alias{mlply}
\title{Call function with arguments in array or data frame, returning a list.}
\usage{
  mlply(.data, .fun = NULL, ..., .expand = TRUE,
    .progress = "none", .parallel = FALSE)
}
\arguments{
  \item{.data}{matrix or data frame to use as source of
  arguments}

  \item{.fun}{function to be called with varying arguments}

  \item{...}{other arguments passed on to \code{.fun}}

  \item{.expand}{should output be 1d (expand = FALSE), with
  an element for each row; or nd (expand = TRUE), with a
  dimension for each variable.}

  \item{.progress}{name of the progress bar to use, see
  \code{\link{create_progress_bar}}}

  \item{.parallel}{if \code{TRUE}, apply function in
  parallel, using parallel backend provided by foreach}
}
\value{
  list of results
}
\description{
  Call a multi-argument function with values taken from
  columns of an data frame or array, and combine results
  into a list
}
\details{
  The \code{m*ply} functions are the \code{plyr} version of
  \code{mapply}, specialised according to the type of
  output they produce.  These functions are just a
  convenient wrapper around \code{a*ply} with \code{margins
  = 1} and \code{.fun} wrapped in \code{\link{splat}}.

  This function combines the result into a list.  If there
  are no results, then this function will return a list of
  length 0 (\code{list()}).
}
\examples{
mlply(cbind(1:4, 4:1), rep)
mlply(cbind(1:4, times = 4:1), rep)

mlply(cbind(1:4, 4:1), seq)
mlply(cbind(1:4, length = 4:1), seq)
mlply(cbind(1:4, by = 4:1), seq, to = 20)
}
\references{
  Hadley Wickham (2011). The Split-Apply-Combine Strategy
  for Data Analysis. Journal of Statistical Software,
  40(1), 1-29.  \url{http://www.jstatsoft.org/v40/i01/}.
}
\keyword{manip}

