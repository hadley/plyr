\name{as.quoted}
\alias{as.quoted}
\alias{as.quoted.call}
\alias{as.quoted.character}
\alias{as.quoted.formula}
\alias{as.quoted.quoted}
\title{Convert input to quoted variables}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
Convert characters, formulas and calls to quoted variables.
}
\usage{as.quoted(x)}
\arguments{
\item{x}{}
}
\value{a list of quoted variables}
\details{This method is called by default on all plyr functions that take a
\code{variables.} argument, so that equivalent forms can be used anywhere.

Currently conversions exist for character vectors, formulas and
call objects.}
\seealso{\code{\link{.}}}
\examples{as.quoted(c("a", "b", "log(d)"))
as.quoted(a ~ b + log(d))}

