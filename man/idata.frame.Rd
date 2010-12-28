\name{idata.frame}
\alias{idata.frame}
\title{Construct an immutable data frame.}
\usage{idata.frame(df)}

\description{
  Construct an immutable data frame.
}

\details{
  An immutable data frame works like an ordinary data
  frame, except that when you subset it, it returns a
  reference to the original data frame, not a a copy. This
  makes subsetting substantially faster and has a big
  impact when you are working with large datasets with many
  groups.

  This method is still a little experimental, so please let
  me know if you run into any problems.
}
\value{an immutable data frame}
\keyword{manip}
\arguments{
  \item{df}{a data frame}
}
\examples{system.time(dlply(baseball, "id", nrow))
system.time(dlply(idata.frame(baseball), "id", nrow))}
