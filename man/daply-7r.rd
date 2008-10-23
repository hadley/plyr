\name{daply}
\alias{daply}
\title{Split data frame, apply function, and return results in an array}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
For each subset of data frame, apply function then combine results into an array
}
\usage{daply(.data, .variables, .fun = NULL, ..., .progress = "none", .drop = TRUE)}
\arguments{
\item{.data}{data frame to be processed}
\item{.variables}{variables to split data frame by, as quoted variables, a formula or character vector}
\item{.fun}{function to apply to each piece}
\item{...}{other arguments passed on to \code{.fun}}
\item{.progress}{name of the progress bar to use, see \code{\link{create_progress_bar}}}
\item{.drop}{should extra dimensions of length 1 be dropped, simplifying the output.  Defaults to \code{TRUE}}
}
\value{if results are atomic with same type and dimensionality, a vector, matrix or array; otherwise, a list-array (a list with dimensions)}
\details{All plyr functions use the same split-apply-combine strategy: they split the
input into simpler pieces, apply \code{.fun} to each piece, and then combine
the pieces into a single data structure.  This function splits data frames
by variable and combines the result into an array.  If there are no results,
then this function will return a vector of length 0 (\code{vector()}).

\code{daply} with a function that operates column-wise is similar to
\code{\link{aggregate}}.

See \code{vignette("intro", "plyr")} for more details, description and case
studies.

@keyword manip
@arguments data frame to be processed
@arguments variables to split data frame by, as quoted variables, a formula or character vector
@arguments function to apply to each piece
@arguments other arguments passed on to \code{.fun}
@arguments name of the progress bar to use, see \code{\link{create_progress_bar}}
@arguments should extra dimensions of length 1 be dropped, simplifying the output.  Defaults to \code{TRUE}
@value if results are atomic with same type and dimensionality, a vector, matrix or array; otherwise, a list-array (a list with dimensions)}

\examples{daply(baseball, .(year), nrow)

# Several different ways of summarising by variables that should not be 
# included in the summary

daply(baseball[, c(2, 6:9)], .(year), mean)
daply(baseball[, 6:9], .(baseball$year), mean)
daply(baseball, .(year), function(df) mean(df[, 6:9]))}
\keyword{manip}
