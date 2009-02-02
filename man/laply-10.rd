\name{laply}
\alias{laply}
\title{Split list, apply function, and return results in an array}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
For each element of a list, apply function then combine results into an array
}
\usage{laply(.data, .fun = NULL, ..., .progress = "none", .drop = TRUE)}
\arguments{
\item{.data}{input list}
\item{.fun}{function to apply to each piece}
\item{...}{other arguments passed on to \code{.fun}}
\item{.progress}{name of the progress bar to use, see \code{\link{create_progress_bar}}}
\item{.drop}{should extra dimensions of length 1 be dropped, simplifying the output.  Defaults to \code{TRUE}}
}
\value{if results are atomic with same type and dimensionality, a vector, matrix or array; otherwise, a list-array (a list with dimensions)}
\details{All plyr functions use the same split-apply-combine strategy: they split the
input into simpler pieces, apply \code{.fun} to each piece, and then combine
the pieces into a single data structure.  This function splits lists by
elements and combines the result into an array.  If there are no results,
then this function will return a vector of length 0 (\code{vector()}).

\code{laply} is very similar in spirit to \code{\link{sapply}} except that
it will always return an array, and the output is transposed with respect
\code{sapply} - each element of the list corresponds to a column, not a
row.


@keyword manip
@arguments input list
@arguments function to apply to each piece
@arguments other arguments passed on to \code{.fun}
@arguments name of the progress bar to use, see \code{\link{create_progress_bar}}
@arguments should extra dimensions of length 1 be dropped, simplifying the output.  Defaults to \code{TRUE}
@value if results are atomic with same type and dimensionality, a vector, matrix or array; otherwise, a list-array (a list with dimensions)}

\examples{laply(baseball, is.factor)
# cf
ldply(baseball, is.factor)
colwise(is.factor)(baseball)

laply(seq_len(10), identity)
laply(seq_len(10), rep, times = 4)
laply(seq_len(10), matrix, nrow = 2, ncol = 2)}
\keyword{manip}
