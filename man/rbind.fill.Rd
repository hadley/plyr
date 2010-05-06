\name{rbind.fill}
\alias{rbind.fill}
\title{Combine data...}
\usage{rbind.fill(...)}

\description{
  Combine data.frames by row, filling in missing columns. \code{rbind}s
  a list of data frames filling missing columns with NA.
}

\details{
  This is an enhancement to \code{\link{rbind}} which adds in columns
  that are not present in all inputs, accepts a list of data frames,
  and operates substantially faster.

  Column names and types in the output will appear in the order in
  which they were encoutered. No checking is performed to ensure that
  each column is of consistent type in the inputs.
}
\keyword{manip}
\value{a single data frame}
\arguments{
  \item{...}{input data frames to row bind together}
}
\examples{rbind.fill(mtcars[c("mpg", "wt")], mtcars[c("wt", "cyl")])}
