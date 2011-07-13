\name{loop_apply}
\alias{loop_apply}
\title{Loop apply}
\usage{
  loop_apply(n, f, env = parent.frame())
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
\keyword{internal}
\keyword{manip}

