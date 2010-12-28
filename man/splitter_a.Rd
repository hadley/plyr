\name{splitter_a}
\alias{splitter_a}
\title{Split an array by...}
\usage{splitter_a(data, .margins=1, .expand=TRUE)}

\description{
  Split an array by .margins. Split a 2d or higher data
  structure into lower-d pieces based
}

\details{
  This is the workhorse of the \code{a*ply} functions.
  Given a >1 d data structure (matrix, array, data.frame),
  it splits it into pieces based on the subscripts that you
  supply.  Each piece is a lower dimensional slice.

  The margins are specified in the same way as
  \code{\link{apply}}, but \code{splitter_a} just splits up
  the data, while \code{apply} also applies a function and
  combines the pieces back together.  This function also
  includes enough information to recreate the split from
  attributes on the list of pieces.
}
\value{a list of lower-d slices, with attributes that record split details}
\keyword{internal}
\arguments{
  \item{data}{>1d data structure (matrix, data.frame or array)}
  \item{.margins}{a vector giving the subscripts to split up \code{data} by.}
  \item{.expand}{if splitting a dataframe by row, should output be 1d 
(expand = FALSE), with an element for each row; or nd (expand = TRUE), 
with a dimension for each variable.}
}
\examples{plyr:::splitter_a(mtcars, 1)
plyr:::splitter_a(mtcars, 2)

plyr:::splitter_a(ozone, 2)
plyr:::splitter_a(ozone, 3)
plyr:::splitter_a(ozone, 1:2)}
