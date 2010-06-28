\name{margins}
\alias{margins}
\title{Figure out margining variables.}
\usage{margins(rows, cols, margins)}

\description{
  Figure out margining variables. Given the variables that form the
  rows and columns, and a set of desired margins, works out which ones
  are possible. Variables that can't be margined over are dropped
  silently.
}
\keyword{manip}
\keyword{internal}
\value{list of margining combinations, or \code{NULL} if none. These are
the combinations of variables that should have their values set to 
`(all)`}
\arguments{
  \item{col}{a character vector of column names}
  \item{row}{a character vector of row names}
  \item{margins}{a character vector of variable names to margin over.  Can be
any variable name in \code{col} or \code{row}, \code{"grand_row"} or
\code{"grand_col"}.  If \code{TRUE} will compute all possible margins.}
}
