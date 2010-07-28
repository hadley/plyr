\name{melt}
\alias{melt}
\title{Convert an object into a molten data frame.}
\usage{melt(data, ...)}

\description{
  Convert an object into a molten data frame.
}

\details{
  This the generic melt function. See the following functions for the
  details about different data structures:

  \itemize{ \item \code{\link{melt.data.frame}} for data.frames \item
  \code{\link{melt.array}} for arrays, matrices and tables \item
  \code{\link{melt.list}} for lists }
}
\keyword{manip}
\arguments{
  \item{data}{Data set to melt}
  \item{...}{further arguments passed to or from other methods.}
}
