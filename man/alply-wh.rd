\name{alply}
\alias{alply}
\title{Split array, apply function, and return results in a list}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
For each slice of an array, apply function then combine results into a list
}
\usage{alply(.data, .margins, .fun = NULL, ..., .progress = "none")}
\arguments{
\item{.data}{matrix, array or data frame to be processed}
\item{.margins}{a vector giving the subscripts to split up \code{data} by.  1 splits up by rows, 2 by columns and c(1,2) by rows and columns, and so on for higher dimensions}
\item{.fun}{function to apply to each piece}
\item{...}{other arguments passed on to \code{.fun}}
\item{.progress}{name of the progress bar to use, see \code{\link{create_progress_bar}}}
}
\value{list of results}
\details{All plyr functions use the same split-apply-combine strategy: they split the
input into simpler pieces, apply \code{.fun} to each piece, and then combine
the pieces into a single data structure.  This function splits matrices,
arrays and data frames by dimensions and combines the result into a list.
If there are no results, then this function will return a list of length 0
(\code{list()}).

\code{alply} is somewhat similar to \code{\link{apply}} for cases where the
results are not atomic.

See \code{vignette("intro", "plyr")} for more details, description and case
studies.

@keyword manip
@arguments matrix, array or data frame to be processed
@arguments a vector giving the subscripts to split up \code{data} by.  1 splits up by rows, 2 by columns and c(1,2) by rows and columns, and so on for higher dimensions
@arguments function to apply to each piece
@arguments other arguments passed on to \code{.fun}
@arguments name of the progress bar to use, see \code{\link{create_progress_bar}}
@value list of results}

\examples{alply(ozone, 3, quantile)
alply(ozone, 3, function(x) table(round(x)))}
\keyword{manip}
