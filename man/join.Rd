\name{join}
\alias{join}
\title{Join two data frames together.}
\usage{join(x, y, by=intersect(names(x), names(y)), type="left")}

\description{
  Join two data frames together.
}

\details{
  Unlike merge, preserves the order of x no matter what join type is
  used. If needed, rows from y will be added to the bottom.

  Join is about four times faster than merge, but it achieves this
  speed by being less flexible, and is designed for the types of
  problems where you would use a sql join.
}
\keyword{manip}
\arguments{
  \item{x}{data frame}
  \item{y}{data frame}
  \item{by}{character vector of variable names to join by}
  \item{type}{type of join: left (default), right, inner or full.}
}
\examples{first <- ddply(baseball, "id", summarise, first = min(year))
system.time(b2 <- merge(baseball, first, by = "id", all.x = TRUE))
system.time(b3 <- join(baseball, first, by = "id"))

b2 <- arrange(b2, id, year, stint)
b3 <- arrange(b3, id, year, stint)
stopifnot(all.equal(b2, b3))}
