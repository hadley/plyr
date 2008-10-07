\name{d_ply}
\alias{d_ply}
\title{Split data frame, apply function, and discard results}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
For each subset of a data frame, apply function and discard results
}
\usage{d_ply(.data, .variables, .fun = NULL, ..., .progress = "none", .print = FALSE)}
\arguments{
\item{.data}{data frame to be processed}
\item{.variables}{variables to split data frame by, as quoted variables, a formula or character vector}
\item{.fun}{function to apply to each piece}
\item{...}{other arguments passed on to \code{.fun}}
\item{.progress}{name of the progress bar to use, see \code{\link{create_progress_bar}}}
\item{.print}{}
}

\details{All plyr functions use the same split-apply-combine strategy: they split the
input into simpler pieces, apply \code{.fun} to each piece, and then combine
the pieces into a single data structure.  This function splits data frames
by variable and discards the output.  This is useful for functions that you
are calling purely for their side effects like display plots and saving
output.

See \code{vignette("intro", "plyr")} for more details, description and case
studies.}

\examples{}
\keyword{manip}
