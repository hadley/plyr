\name{summarise}
\title{Summarise a data frame.}
\usage{summarise(.data, ...)}

\description{
  Summarise a data frame. Create a new data frame that summarises an
  existing data frame.
}

\details{
  Summarise works in an analagous way to transform, except instead of
  adding columns to an existing data frame, it creates a new one.  This
  is particularly useful in conjunction with \code{\link{ddply}} as it
  makes it easy to perform group-wise summaries.
}
\keyword{manip}
\alias{summarise}
\alias{summarize}
\arguments{
  \item{.data}{the data frame to be summarised}
  \item{...}{further arguments of the form var = value}
}
\examples{summarise(baseball, 
duration = max(year) - min(year), 
nteams = length(unique(team)))
ddply(baseball, "id", summarise, 
duration = max(year) - min(year), 
nteams = length(unique(team)))}
