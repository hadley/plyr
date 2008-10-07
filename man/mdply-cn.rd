\name{mdply}
\alias{mdply}
\title{Call function with arguments in array or data frame, returning a data frame}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
Call a multi-argument function with values taken from columns of an data frame or array, and combine results into a data frame
}
\usage{mdply(.data, .fun = NULL, ..., .progress = "none")}
\arguments{
\item{.data}{matrix or data frame to use as source of arguments}
\item{.fun}{function to be called with varying arguments}
\item{...}{other arguments passed on to \code{.fun}}
\item{.progress}{name of the progress bar to use, see \code{\link{create_progress_bar}}}
}
\value{a data frame}
\details{The \code{m*ply} functions are the \code{plyr} version of \code{mapply},
specialised according to the type of output they produce.  These functions
are just a convenient wrapper around \code{a*ply} with \code{margins = 1}
and \code{.fun} wrapped in \code{\link{splat}}.

This function combines the result into a data frame.  If there are no
results, then this function will return a data frame with zero rows and
columns (\code{data.frame()}).

See \code{vignette("intro", "plyr")} for more details, description and case
studies.}

\examples{mdply(data.frame(mean = 1:5, sd = 1:5), rnorm, n = 2)
mdply(expand.grid(mean = 1:5, sd = 1:5), rnorm, n = 2)
mdply(cbind(mean = 1:5, sd = 1:5), rnorm, n = 5)}
\keyword{manip}
