\name{rbind.fill}
\alias{rbind.fill}
\title{Combine objects by row, filling in missing columns}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
\code{rbind}s a list of data frames filling missing columns with NA
}
\usage{rbind.fill(...)}
\arguments{
\item{...}{data frames to row bind together}
}

\details{This is a minor enhancement to \code{\link{rbind}} which adds in columns
that are not present in all inputs.}

\examples{rbind.fill(mtcars[c("mpg", "wt")], mtcars[c("wt", "cyl")])}
\keyword{manip}
