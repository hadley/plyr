\name{llply}
\alias{llply}
\title{Split list, apply function, and return results in a list.}
\usage{llply(.data, .fun, ..., .progress="none", .inform=FALSE)}

\description{
  Split list, apply function, and return results in a list. For each
  element of a list, apply function then combine results into a list
}

\details{
  All plyr functions use the same split-apply-combine strategy: they
  split the input into simpler pieces, apply \code{.fun} to each piece,
  and then combine the pieces into a single data structure.  This
  function splits lists by elements and combines the result into a
  list.  If there are no results, then this function will return a list
  of length 0 (\code{list()}).

  \code{llply} is equivalent to \code{\link{lapply}} except that it
  will preserve labels and can display a progress bar.
}
\keyword{manip}
\value{list of results}
\arguments{
  \item{.data}{list to be processed}
  \item{.fun}{function to apply to each piece}
  \item{...}{other arguments passed on to \code{.fun}}
  \item{.progress}{name of the progress bar to use, see \code{\link{create_progress_bar}}}
  \item{.inform}{produce informative error messages?  This is turned off by
by default because it substantially slows processing speed, but is very
useful for debugging}
}
\examples{llply(llply(mtcars, round), table)
llply(baseball, summary)
# Examples from ?lapply
x <- list(a = 1:10, beta = exp(-3:3), logic = c(TRUE,FALSE,FALSE,TRUE))

llply(x, mean)
llply(x, quantile, probs = 1:3/4)}
