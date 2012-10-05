\name{summarise}
\alias{summarise}
\alias{summarize}
\title{Summarise a data frame.}
\usage{
  summarise(.data, ...)
}
\arguments{
  \item{.data}{the data frame to be summarised}

  \item{...}{further arguments of the form var = value}
}
\description{
  Summarise works in an analagous way to transform, except
  instead of adding columns to an existing data frame, it
  creates a new data frame.  This is particularly useful in
  conjunction with \code{\link{ddply}} as it makes it easy
  to perform group-wise summaries.
}
\examples{
# Let's extract the number of teams and total period of time
# covered by the baseball dataframe
summarise(baseball,
 duration = max(year) - min(year),
 nteams = length(unique(team)))
# Combine with ddply to do that for each separate id
ddply(baseball, "id", summarise,
 duration = max(year) - min(year),
 nteams = length(unique(team)))
}
\keyword{manip}

