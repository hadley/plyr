\name{l_ply}
\alias{l_ply}
\title{Split list, apply function, and discard results.}
\usage{
  l_ply(.data, .fun = NULL, ..., .progress = "none",
    .print = FALSE, .parallel = FALSE)
}
\arguments{
  \item{.fun}{function to apply to each piece}

  \item{...}{other arguments passed on to \code{.fun}}

  \item{.progress}{name of the progress bar to use, see
  \code{\link{create_progress_bar}}}

  \item{.parallel}{if \code{TRUE}, apply function in
  parallel, using parallel backend provided by foreach}

  \item{.data}{list to be processed}

  \item{.print}{automatically print each result? (default:
  \code{FALSE})}
}
\value{
  Nothing
}
\description{
  For each element of a list, apply function and discard
  results
}
\section{Input}{
  This function splits lists by elements.
}

\section{Output}{
  All output is discarded. This is useful for functions
  that you are calling purely for their side effects like
  displaying plots or saving output.
}
\references{
  Hadley Wickham (2011). The Split-Apply-Combine Strategy
  for Data Analysis. Journal of Statistical Software,
  40(1), 1-29.  \url{http://www.jstatsoft.org/v40/i01/}.
}
\seealso{
  Other list input: \code{\link{laply}},
  \code{\link{ldply}}, \code{\link{llply}}

  Other no output: \code{\link{a_ply}},
  \code{\link{d_ply}}, \code{\link{m_ply}}
}
\keyword{manip}

