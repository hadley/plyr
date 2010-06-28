\name{rlply}
\alias{rlply}
\title{Replicate expression and return results in a list.}
\usage{rlply(.n, .expr, .progress="none")}

\description{
  Replicate expression and return results in a list. Evalulate
  expression n times then combine results into a list
}

\details{
  This function runs an expression multiple times, and combines the
  result into a list.  If there are no results, then this function will
  return a list of length 0 (\code{list()}). This function is
  equivalent to \code{\link{replicate}}, but will always return results
  as a list.
}
\keyword{manip}
\value{list of results}
\arguments{
  \item{.n}{number of times to evaluate the expression}
  \item{.expr}{expression to evaluate}
  \item{.progress}{name of the progress bar to use, see \code{\link{create_progress_bar}}}
}
\examples{mods <- rlply(100, lm(y ~ x, data=data.frame(x=rnorm(100), y=rnorm(100))))
hist(laply(mods, function(x) summary(x)$r.squared))}
