\name{each}
\alias{each}
\title{Aggregate multiple functions into a single function.}
\usage{
  each(...)
}
\arguments{
  \item{...}{functions to combine}
}
\description{
  Combine multiple functions to a single function returning
  a named vector of outputs
}
\details{
  Each function should produce a single number as output
}
\examples{
each(min, max)(1:10)
each("min", "max")(1:10)
each(c("min", "max"))(1:10)
each(c(min, max))(1:10)
each(length, mean, var)(rnorm(100))
}
\keyword{manip}

