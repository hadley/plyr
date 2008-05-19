\name{daply}
\alias{daply}
\title{X daply(baseball, .(year), nrow)}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
X
}
\usage{daply(data, vars, fun = NULL, ..., .progress = "none")}
\arguments{
\item{data}{}
\item{vars}{}
\item{fun}{}
\item{...}{}
\item{.progress}{}
}

\details{}

\examples{daply(baseball, .(year), nrow)

# Several different ways of summarising by variables that should not be 
# included in the summary

daply(baseball[, c(2, 6:9)], .(year), mean)
daply(baseball[, 6:9], .(baseball$year), mean)
daply(baseball, .(year), function(df) mean(df[, 6:9]))}

