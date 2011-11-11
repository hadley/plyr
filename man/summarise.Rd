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
  creates a new one.  This is particularly useful in
  conjunction with \code{\link{ddply}} as it makes it easy
  to perform group-wise summaries.
}
\examples{
summarise(baseball,
 duration = max(year) - min(year),
 nteams = length(unique(team)))
ddply(baseball, "id", summarise,
 duration = max(year) - min(year),
 nteams = length(unique(team)))
}
\keyword{manip}

