\name{quickdf}
\alias{quickdf}
\title{Quick data frame.}
\usage{quickdf(list)}

\description{
  Quick data frame.
}

\details{
  Experimental version of \code{\link{as.data.frame}} that
  converts a list to a data frame, but doesn't do any
  checks to make sure it's a valid format.  Much faster.
}
\keyword{internal}
\arguments{
  \item{list}{list to convert to data frame}
}
