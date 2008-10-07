\name{maply}
\alias{maply}
\title{Call function with arguments in array or data frame, returning an array}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
Call a multi-argument function with values taken from columns of an data frame or array, and combine results into an array
}
\usage{maply(.data, .fun = NULL, ..., .progress = "none")}
\arguments{
\item{.data}{matrix or data frame to use as source of arguments}
\item{.fun}{function to be called with varying arguments}
\item{...}{other arguments passed on to \code{.fun}}
\item{.progress}{name of the progress bar to use, see \code{\link{create_progress_bar}}}
}
\value{if results are atomic with same type and dimensionality, a vector, matrix or array; otherwise, a list-array (a list with dimensions)}
\details{The \code{m*ply} functions are the \code{plyr} version of \code{mapply},
specialised according to the type of output they produce.  These functions
are just a convenient wrapper around \code{a*ply} with \code{margins = 1}
and \code{.fun} wrapped in \code{\link{splat}}.

This function combines the result into an array.  If there are no results,
then this function will return a vector of length 0 (\code{vector()}).

See \code{vignette("intro", "plyr")} for more details, description and case
studies.}

\examples{maply(cbind(mean = 1:5, sd = 1:5), rnorm, n = 5)
maply(cbind(1:5, 1:5), rnorm, n = 5)
maply(expand.grid(mean = 1:5, sd = 1:5), rnorm, n = 5)}
\keyword{manip}
