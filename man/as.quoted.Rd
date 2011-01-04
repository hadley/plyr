\name{as.quoted}
\title{Convert input to quoted variables.}
\usage{as.quoted(x, env=parent.frame())}

\description{
  Convert input to quoted variables. Convert characters,
  formulas and calls to quoted .variables
}

\details{
  This method is called by default on all plyr functions
  that take a \code{.variables} argument, so that
  equivalent forms can be used anywhere.

  Currently conversions exist for character vectors,
  formulas and call objects.
}
\value{a list of quoted variables}
\seealso{\code{\link{.}}}
\alias{as.quoted.call}
\alias{as.quoted.character}
\alias{as.quoted.formula}
\alias{as.quoted.quoted}
\alias{as.quoted.NULL}
\alias{as.quoted.numeric}
\alias{c.quoted}
\alias{as.quoted}
\alias{[.quoted}
\arguments{
  \item{x}{input to quote}
  \item{env}{environment in which unbound symbols in expression should be
evaluated. Defaults to the environment in which \code{as.quoted} was 
executed.}
}
\examples{as.quoted(c("a", "b", "log(d)"))
as.quoted(a ~ b + log(d))}
