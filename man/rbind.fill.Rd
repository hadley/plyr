\name{rbind.fill}
\alias{rbind.fill}
\title{Combine objects by row, filling in missing columns.}
\usage{rbind.fill(...)}
\description{Combine objects by row, filling in missing columns.
\code{rbind}s a list of data frames filling missing columns with NA.}
\details{This is an enhancement to \code{\link{rbind}} which adds in columns
that are not present in all inputs, accepts a list of data frames, and 
operates substantially faster}
\keyword{manip}
\arguments{\item{...}{data frames to row bind together}}
\examples{rbind.fill(mtcars[c("mpg", "wt")], mtcars[c("wt", "cyl")])}
