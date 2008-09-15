\name{as.data.frame.function}
\alias{as.data.frame.function}
\title{Make a function return a data frame}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
Create a new function that returns the existing function wrapped in a data.frame
}
\usage{as.data.frame.function(x, row.names, optional, ...)}
\arguments{
\item{x}{}
\item{row.names}{}
\item{optional}{}
\item{...}{}
}

\details{This is useful when calling \code{*dply} functions with a function that
returns a vector, and you want the output in rows, rather than columns}

\examples{}
\keyword{manip}
