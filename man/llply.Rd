\name{llply}
\alias{llply}
\title{Split list, apply function, and return results in a list.}
\usage{
  llply(.data, .fun = NULL, ..., .progress = "none",
    .inform = FALSE, .parallel = FALSE)
}
\arguments{
  \item{.fun}{function to apply to each piece}

  \item{...}{other arguments passed on to \code{.fun}}

  \item{.progress}{name of the progress bar to use, see
  \code{\link{create_progress_bar}}}

  \item{.data}{list to be processed}

  \item{.parallel}{if \code{TRUE}, apply function in
  parallel, using parallel backend provided by foreach}

  \item{.inform}{produce informative error messages?  This
  is turned off by by default because it substantially
  slows processing speed, but is very useful for debugging}
}
\value{
  list of results
}
\description{
  For each element of a list, apply function, keeping
  results as a list. \code{llply} is equivalent to
  \code{\link{lapply}} except that it will preserve labels
  and can display a progress bar.
}
\section{Input}{
  This function splits lists by elements and combines the
  result into a data frame.
}

\section{Output}{
  If there are no results, then this function will return a
  list of length 0 (\code{list()}).
}
\examples{
llply(llply(mtcars, round), table)
llply(baseball, summary)
# Examples from ?lapply
x <- list(a = 1:10, beta = exp(-3:3), logic = c(TRUE,FALSE,FALSE,TRUE))

llply(x, mean)
llply(x, quantile, probs = 1:3/4)
}
\references{
  Hadley Wickham (2011). The Split-Apply-Combine Strategy
  for Data Analysis. Journal of Statistical Software,
  40(1), 1-29.  \url{http://www.jstatsoft.org/v40/i01/}.
}
\seealso{
  Other list input: \code{\link{laply}},
  \code{\link{ldply}}

  Other list output: \code{\link{alply}},
  \code{\link{dlply}}
}
\keyword{manip}

