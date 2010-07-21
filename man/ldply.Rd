\name{ldply}
\alias{ldply}
\title{Split list, apply function, and return results in a data frame.}
\usage{ldply(.data, .fun, ..., .progress="none", .parallel=FALSE)}

\description{
  Split list, apply function, and return results in a data frame. For
  each element of a list, apply function then combine results into a
  data frame
}

\details{
  All plyr functions use the same split-apply-combine strategy: they
  split the input into simpler pieces, apply \code{.fun} to each piece,
  and then combine the pieces into a single data structure.  This
  function splits lists by elements and combines the result into a data
  frame.  If there are no results, then this function will return a
  data frame with zero rows and columns (\code{data.frame()}).

  The most unambiguous behaviour is achieved when \code{.fun} returns a
  data frame - in that case pieces will be combined with
  \code{\link{rbind.fill}}.  If \code{.fun} returns an atomic vector of
  fixed length, it will be \code{rbind}ed together and converted to a
  data frame. Any other values will result in an error.
}
\keyword{manip}
\value{a data frame}
\arguments{
  \item{.data}{list to be processed}
  \item{.fun}{function to apply to each piece}
  \item{...}{other arguments passed on to \code{.fun}}
  \item{.progress}{name of the progress bar to use, see \code{\link{create_progress_bar}}}
  \item{.parallel}{if \code{TRUE}, apply function in parallel, using parallel 
backend provided by foreach}
}
