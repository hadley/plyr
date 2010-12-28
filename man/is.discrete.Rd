\name{is.discrete}
\alias{is.discrete}
\title{Determine if a vector is discrete.}
\usage{is.discrete(x)}

\description{
  Determine if a vector is discrete. A discrete vector is a
  factor or a character vector
}
\keyword{internal}
\arguments{
  \item{x}{vector to test}
}
\examples{is.discrete(1:10)
is.discrete(c("a", "b", "c"))
is.discrete(factor(c("a", "b", "c")))}
