\name{summarise}
\alias{summarise}
\alias{summarize}
\title{Summarise a data frame.}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
Create a new data frame that summarises an existing data frame.
}
\usage{summarise(.data, ...)}
\arguments{
\item{.data}{The data frame to be summarised}
\item{...}{Further arguments of the form var = value}
}

\details{Summarise works in an analagous way to transform, except instead of adding
columns to an existing data frame, it creates a new one.  This is
particularly useful in conjunction with \code{\link{ddply}} as it makes it
easy to perform group-wise summaries.}

\examples{summarise(baseball, 
duration = max(year) - min(year), 
nteams = length(unique(team)))
ddply(baseball, "id", summarise, 
duration = max(year) - min(year), 
nteams = length(unique(team)))}
\keyword{manip}
