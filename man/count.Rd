\name{count}
\alias{count}
\title{Count the number of occurences.}
\usage{count(df, vars)}

\description{
  Count the number of occurences. Equivalent to
  \code{as.data.frame(table(x))}, but does not include combinations
  with zero counts.
}

\details{
  Count is speed competitive with \code{\link{table}} for single
  variables, but it really comes into its own when summarising multiple
  dimensions that are not crossed.
}
\value{a data frame with label and freq columns}
\keyword{manip}
\arguments{
  \item{df}{data frame to be processed}
  \item{vars}{variables to count unique values of}
}
\examples{count(baseball, "id")
count(baseball, "lg")
count(baseball, "stint")
count(count(baseball, c("id", "year")), "freq")}
