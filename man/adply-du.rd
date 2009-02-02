\name{adply}
\alias{adply}
\title{Split array, apply function, and return results in a data frame}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
For each slice of an array, apply function then combine results into a data frame
}
\usage{adply(.data, .margins, .fun = NULL, ..., .progress = "none")}
\arguments{
\item{.data}{matrix, array or data frame to be processed}
\item{.margins}{a vector giving the subscripts to split up \code{data} by.  1 splits up by rows, 2 by columns and c(1,2) by rows and columns, and so on for higher dimensions}
\item{.fun}{function to apply to each piece}
\item{...}{other arguments passed on to \code{.fun}}
\item{.progress}{name of the progress bar to use, see \code{\link{create_progress_bar}}}
}
\value{a data frame}
\details{All plyr functions use the same split-apply-combine strategy: they split the
input into simpler pieces, apply \code{.fun} to each piece, and then combine
the pieces into a single data structure. This function splits matrices,
arrays and data frames by dimensions and combines the result into a data
frame. If there are no results, then this function will return a data frame
with zero rows and columns (\code{data.frame()}).
}

\examples{}
\keyword{manip}
