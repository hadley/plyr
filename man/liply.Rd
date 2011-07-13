\name{liply}
\alias{liply}
\title{Experimental iterator based version of llply.}
\usage{
  liply(.iterator, .fun = NULL, ...)
}
\arguments{
  \item{.iterator}{iterator object}

  \item{.fun}{function to apply to each piece}

  \item{...}{other arguments passed on to \code{.fun}}
}
\description{
  Because iterators do not have known length, \code{liply}
  starts by allocating an output list of length 50, and
  then doubles that length whenever it runs out of space.
  This gives O(n ln n) performance rather than the O(n ^ 2)
  performance from the naive strategy of growing the list
  each time.
}
\examples{
if(require("iterators")) {
system.time(dlply(baseball, "id", summarise, mean_rbi = mean(rbi)))
system.time({
baseball_id <- isplit2(baseball, baseball$id)
liply(baseball_id, summarise, mean_rbi = mean(rbi, na.rm = TRUE))
})
# Iterators get used up:
liply(baseball_id, summarise, mean_rbi = mean(rbi, na.rm = TRUE))
}
}
\keyword{manip}

