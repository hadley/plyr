\name{count}
\alias{count}
\title{Count the number of occurences.}
\usage{count(df, vars, wt_var)}

\description{
  Count the number of occurences.
}

\details{
  Equivalent to \code{as.data.frame(table(x))}, but does
  not include combinations with zero counts.

  Speed-wise count is competitive with \code{\link{table}}
  for single variables, but it really comes into its own
  when summarising multiple dimensions because it only
  counts combinations that actually occur in the data.

  Compared to \code{\link{table}} +
  \code{\link{as.data.frame}}, \code{count} also preserves
  the type of the identifier variables, instead of
  converting them to characters/factors.
}
\value{a data frame with label and freq columns}
\keyword{manip}
\arguments{
  \item{df}{data frame to be processed}
  \item{vars}{variables to count unique values of}
  \item{wt_var}{optional variable to weight by - if this is non-NULL, count
will sum up the value of this variable for each combination of id
variables.}
}
\examples{count(baseball, "id")
count(baseball, "id", "g")
count(baseball, "id", "ab")
count(baseball, "lg")
count(baseball, "stint")
count(count(baseball, c("id", "year")), "id", "freq")
count(count(baseball, c("id", "year")), "freq")}
