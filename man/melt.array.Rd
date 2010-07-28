\name{melt.array}
\alias{melt.array}
\title{Melt an array.}
\usage{\method{melt}{array} (data, varnames=names(dimnames(data)), ...)}

\description{
  Melt an array.
}

\details{
  This code is conceptually similar to
  \code{\link{as.data.frame.table}}
}
\keyword{manip}
\arguments{
  \item{data}{array to melt}
  \item{varnames}{variable names to use in molten data.frame}
  \item{...}{further arguments passed to or from other methods.}
}
\examples{a <- array(1:24, c(2,3,4))
melt(a)
melt(a, varnames=c("X","Y","Z"))
dimnames(a) <- lapply(dim(a), function(x) LETTERS[1:x])
melt(a)
melt(a, varnames=c("X","Y","Z"))
dimnames(a)[1] <- list(NULL)
melt(a)}
