\name{id}
\title{A unique numeric id for each unique row in a data frame.}
\usage{id(.variables, drop=FALSE)}

\description{
  A unique numeric id for each unique row in a data frame.
}

\details{
  Properties: \itemize{ \item \code{order(id)} is equivalent to
  \code{do.call(order, df)} \item rows containing the same data have
  the same value \item if \code{drop = FALSE} then room for all
  possibilites }
}
\value{a numeric vector with attribute n, giving total number of
possibilities}
\keyword{internal}
\seealso{\code{\link{id_var}}}
\alias{id}
\alias{ninteraction}
\arguments{
  \item{.variables}{list of variables}
  \item{drop}{drop unusued factor levels?}
}
