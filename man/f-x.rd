\name{f}
\alias{f}
\title{`Splat' arguments to a function}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
Wraps a function in do.call
}
\usage{f(mpg, wt, ...)}
\arguments{
\item{mpg}{function to splat}
\item{wt}{}
\item{...}{}
}

\details{}

\examples{f <- function(mpg, wt, ...) data.frame(mw = mpg / wt)
ddply(mtcars, .(cyl), splat(f))}

