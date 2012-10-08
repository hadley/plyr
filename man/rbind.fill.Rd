\name{rbind.fill}
\alias{rbind.fill}
\title{Combine data.frames by row, filling in missing columns.}
\usage{
  rbind.fill(...)
}
\arguments{
  \item{...}{input data frames to row bind together.  The
  first argument can be a list of data frames, in which
  case all other arguments are ignored.}
}
\value{
  a single data frame
}
\description{
  \code{rbind}s a list of data frames filling missing
  columns with NA.
}
\details{
  This is an enhancement to \code{\link{rbind}} that adds
  in columns that are not present in all inputs, accepts a
  list of data frames, and operates substantially faster.

  Column names and types in the output will appear in the
  order in which they were encountered. No checking is
  performed to ensure that each column is of consistent
  type in the inputs.
}
\examples{
rbind.fill(mtcars[c("mpg", "wt")], mtcars[c("wt", "cyl")])
}
\seealso{
  Other binding functions: \code{\link{rbind.fill.matrix}}
}
\keyword{manip}

