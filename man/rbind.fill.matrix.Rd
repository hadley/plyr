\name{rbind.fill.matrix}
\alias{rbind.fill.matrix}
\title{Bind matrices by row, and fill missing columns with NA.}
\usage{rbind.fill.matrix(...)}

\description{
  Bind matrices by row, and fill missing columns with NA.
}

\details{
  The matrices are bound together using their column names
  or the column indices (in that order of precedence.)
  Numeric columns may be converted to character beforehand,
  e.g. using format.  If a matrix doesn't have colnames,
  the column number is used. Note that this means that a
  column with name \code{"1"} is merged with the first
  column of a matrix without name and so on. The returned
  matrix will always have column names.

  Vectors are converted to 1-column matrices.

  Matrices of factors are not supported. (They are anyways
  quite inconvenient.) You may convert them first to either
  numeric or character matrices. If a matrices of different
  types are merged, then normal covnersion precendence will
  apply.

  Row names are ignored.
}
\value{a matrix with column names}
\author{C. Beleites}
\seealso{\code{\link[base]{rbind}}, \code{\link[base]{cbind}},
\code{\link[plyr]{rbind.fill}}}
\keyword{manip}
\arguments{
  \item{...}{the matrices to rbind}
}
\examples{A <- matrix (1:4, 2)
B <- matrix (6:11, 2)
A
B
rbind.fill.matrix (A, B)

colnames (A) <- c (3, 1)
A
rbind.fill.matrix (A, B)

rbind.fill.matrix (A, 99)}
