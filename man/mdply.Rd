\name{mdply}
\alias{mdply}
\title{Call function with arguments in array or data frame, returning a data frame.}
\usage{mdply(.data, .fun, ..., .expand=TRUE, .progress="none",
    .parallel=FALSE)}

\description{
  Call function with arguments in array or data frame,
  returning a data frame.
}

\details{
  Call a multi-argument function with values taken from
  columns of an data frame or array, and combine results
  into a data frame

  The \code{m*ply} functions are the \code{plyr} version of
  \code{mapply}, specialised according to the type of
  output they produce.  These functions are just a
  convenient wrapper around \code{a*ply} with \code{margins
  = 1} and \code{.fun} wrapped in \code{\link{splat}}.

  This function combines the result into a data frame.  If
  there are no results, then this function will return a
  data frame with zero rows and columns
  (\code{data.frame()}).
}
\keyword{manip}
\value{a data frame}
\references{Hadley Wickham (2011). The Split-Apply-Combine Strategy for
Data Analysis. Journal of Statistical Software, 40(1), 1-29. 
\url{http://www.jstatsoft.org/v40/i01/}.}
\arguments{
  \item{.data}{matrix or data frame to use as source of arguments}
  \item{.fun}{function to be called with varying arguments}
  \item{...}{other arguments passed on to \code{.fun}}
  \item{.expand}{should output be 1d (expand = FALSE), with an element for
each row; or nd (expand = TRUE), with a dimension for each variable.}
  \item{.progress}{name of the progress bar to use, see \code{\link{create_progress_bar}}}
  \item{.parallel}{if \code{TRUE}, apply function in parallel, using parallel 
backend provided by foreach}
}
\examples{mdply(data.frame(mean = 1:5, sd = 1:5), rnorm, n = 2)
mdply(expand.grid(mean = 1:5, sd = 1:5), rnorm, n = 2)
mdply(cbind(mean = 1:5, sd = 1:5), rnorm, n = 5)
mdply(cbind(mean = 1:5, sd = 1:5), as.data.frame(rnorm), n = 5)}
