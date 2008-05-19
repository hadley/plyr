\name{standardise}
\alias{standardise}
\title{X aaply(ozone, 1, mean)}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
X aaply(ozone, 3, mean)
}
\usage{standardise(x)}
\arguments{
\item{x}{}
}

\details{}

\examples{aaply(ozone, 1, mean)
aaply(ozone, 3, mean)
aaply(ozone, c(1,2), mean)

aaply(ozone, 1, each(min, max))
aaply(ozone, 3, each(min, max))

standardise <- function(x) (x - min(x)) / (max(x) - min(x))
aaply(ozone, 3, standardise)
aaply(ozone, 1:2, standardise)}

