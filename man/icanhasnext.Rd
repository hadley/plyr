\name{icanhasnext}
\title{Add has next functionality to any iterator...}
\usage{icanhasnext(iterator)}

\description{
  Add has next functionality to any iterator
}

\details{
  The iterator package relies of catching \code{StopIteration} errors
  to detect when iteration is complete.  This function wraps any
  interator with an iterator that additionally provides a boolean
  \code{hasNext} method which reports whether or not the iterator has
  another element.  This simplifies programming as you can use a simple
  while loop, instead of needing a \code{tryCatch} to detect
  completion.
}
\keyword{internal}
\alias{end_iteration}
\alias{iteration_has_ended}
\alias{new_iterator}
\alias{is.iterator}
\alias{icanhasnext}
\arguments{
  \item{iterator}{iterator to add \code{hasNext} capability to}
}
\examples{if (require("iterators")) {
it <- icanhasnext(icount(3))
while(it$hasNext()) print(it$nextElem())
}}
