\name{splitter_d}
\alias{splitter_d}
\title{Split a data frame by variables}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
Split a data frame into pieces based on variable contained in that data frame
}
\usage{splitter_d(data, variables. = NULL)}
\arguments{
\item{data}{}
\item{variables.}{}
}
\value{a list of data.frames, with attributes that record split details}
\details{This is the workhorse of the \code{d*ply} functions.  Based on the variables
you supply, it breaks up a single data frame into a list of data frames,
each containing a single combination from the levels of the specified
variables.

This is basically a thin wrapper around \code{\link{split}} which
evaluates the variables in the context of the data, and includes enough
information to reconstruct the labelling of the data frame after
other operations.}
\seealso{\code{\link{.}} for quoting variables, \code{\link{split}}}
\examples{splitter_d(mtcars, .(cyl))
splitter_d(mtcars, .(vs, am))
splitter_d(mtcars, .(am, vs))}

