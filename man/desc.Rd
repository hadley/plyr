\name{desc}
\alias{desc}
\title{Descending order.}
\usage{desc(x)}

\description{
  Descending order.
}

\details{
  Transform a vector into a format that will be sorted in descending
  order.
}
\keyword{manip}
\arguments{
  \item{x}{vector to transform}
}
\examples{desc(1:10)
desc(factor(letters))
first_day <- seq(as.Date("1910/1/1"), as.Date("1920/1/1"), "years")
desc(first_day)}
