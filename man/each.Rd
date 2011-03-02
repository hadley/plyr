\name{each}
\alias{each}
\title{Aggregate multiple functions into a single function.}
\usage{each(...)}

\description{
  Aggregate multiple functions into a single function.
}

\details{
  Combine multiple functions to a single function returning
  a named vector of outputs

  Each function should produce a single number as output
}
\keyword{manip}
\arguments{
  \item{...}{functions to combine}
}
\examples{each(min, max)(1:10)
each("min", "max")(1:10)
each(c("min", "max"))(1:10)
each(c(min, max))(1:10)
each(length, mean, var)(rnorm(100))}
