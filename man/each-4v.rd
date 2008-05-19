\name{each}
\alias{each}
\title{Aggregate multiple functions into a single function}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
Combine multiple functions to a single function returning a named vector of outputs
}
\usage{each(...)}
\arguments{
\item{...}{functions to combine}
}

\details{Each function should produce a single number as output}

\examples{each(min, max)(1:10)
each(length, mean, var)(rnorm(100))}
\keyword{manip}
