\name{as.data.frame.function}
\alias{as.data.frame.function}
\title{Make a function return a data frame.}
\usage{\method{as.data.frame}{function} (x, row.names, optional,
    ...)}

\description{
  Make a function return a data frame.
}

\details{
  Create a new function that returns the existing function
  wrapped in a data.frame

  This is useful when calling \code{*dply} functions with a
  function that returns a vector, and you want the output
  in rows, rather than columns
}
\keyword{manip}
\arguments{
  \item{x}{function to make return a data frame}
  \item{row.names}{necessary to match the generic, but not used}
  \item{optional}{necessary to match the generic, but not used}
  \item{...}{necessary to match the generic, but not used}
}
