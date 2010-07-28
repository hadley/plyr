\name{melt.list}
\alias{melt.list}
\title{Melt a list by recursively melting each component.}
\usage{\method{melt}{list} (data, ..., level=1)}

\description{
  Melt a list by recursively melting each component.
}
\keyword{manip}
\arguments{
  \item{data}{list to recursively melt}
  \item{...}{further arguments passed to or from other methods.}
  \item{level}{list level - used for creating labels}
}
\examples{a <- as.list(1:4)
melt(a)
names(a) <- letters[1:4]
melt(a)
a <- list(matrix(1:4, ncol=2), matrix(1:6, ncol=2))
melt(a)
a <- list(matrix(1:4, ncol=2), array(1:27, c(3,3,3)))
melt(a)
melt(list(1:5, matrix(1:4, ncol=2)))
melt(list(list(1:3), 1, list(as.list(3:4), as.list(1:2))))}
