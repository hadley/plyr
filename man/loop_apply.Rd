\name{loop_apply}
\alias{loop_apply}
\title{Loop apply}
\usage{
loop_apply(n, f)
}
\arguments{
  \item{n}{length of sequence}

  \item{f}{function to apply to each integer}

  \item{env}{environment in which to evaluate function}
}
\description{
An optimised version of lapply for the special case of
operating on \code{seq_len(n)}
}
\examples{
loop_apply(10, function(x) x ^ 2)
y <- 10
loop_apply(10, function(x) x + y)

f <- function() {
  y <- 100
  loop_apply(10, function(x) x + y)
}
f()
}
\keyword{internal}
\keyword{manip}

