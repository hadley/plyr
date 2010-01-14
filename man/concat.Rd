\name{concat}
\alias{concat}
\title{Combine vectors...}
\usage{concat(...)}

\description{
  Combine vectors
}

\details{
  Works like \code{\link{c}} but does not drop attributes, thus making
  it useful for factors and dates etc.  This function does not perform
  coercion so all objects should be of the same type.

  Zero length input are silently dropped.
}
\arguments{
  \item{...}{set of vectors to combine}
}
