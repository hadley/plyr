\name{colwise}
\alias{colwise}
\alias{catcolwise}
\alias{numcolwise}
\title{Column-wise function}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
Turn a function that operates on a vector into a function that operates column-wise on a data.frame
}
\usage{colwise(.fun, .if = function(x) TRUE)}
\arguments{
\item{.fun}{function}
\item{.if}{should the function with wrapped with \code{\link{failwith}(NA)}}
\item{}{function that tests columns for inclusion}
}

\details{\code{catcolwise} and \code{numcolwise} provide version that only operate
on discrete and numeric variables respectively}

\examples{}

