\name{rdply}
\alias{rdply}
\title{Replicate expression and return results in a data frame}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
Evalulate expression n times then combine results into a data frame
}
\usage{rdply(.n, .expr, .progress = "none")}
\arguments{
\item{.n}{number of times to evaluate the expression}
\item{.expr}{expression to evaluate}
\item{.progress}{name of the progress bar to use, see \code{\link{create_progress_bar}}}
}
\value{a data frame}
\details{This function runs an expression multiple times, and combines the
result into a data frame.  If there are no results, then this function
returns a data frame with zero rows and columns (\code{data.frame()}).
This function is equivalent to \code{\link{replicate}}, but will always
return results as a data frame.

See \code{vignette("intro", "plyr")} for more details, description and case
studies.}

\examples{
rdply(20, mean(runif(100)))
rdply(20, each(mean, var)(runif(100)))
rdply(20, data.frame(x = runif(2)))}
\keyword{manip}
