\name{adply}
\alias{adply}
\title{X adply(ozone, 1, mean)}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
X adply(ozone, 3, mean)
}
\usage{adply(data, margins, fun = NULL, ..., .progress = "none")}
\arguments{
\item{data}{}
\item{margins}{}
\item{fun}{}
\item{...}{}
\item{.progress}{}
}

\details{}

\examples{adply(ozone, 1, mean)
adply(ozone, 3, mean)
adply(ozone, c(1,2), mean)
adply(ozone, c(1,2), each(mean, max, min))}

