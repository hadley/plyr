\name{splitter_a}
\alias{splitter_a}
\title{Split an array by .margins}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
Split a 2d or higher data structure into lower-d pieces based
}
\usage{splitter_a(data, .margins = 1)}
\arguments{
\item{data}{}
\item{.margins}{}
}
\value{a list of lower-d slices, with attributes that record split details}
\details{This is the workhorse of the \code{a*ply} functions.  Given a >1 d
data structure (matrix, array, data.frame), it splits it into pieces
based on the subscripts that you supply.  Each piece is a lower dimensional
slice.

The margins are specified in the same way as \code{\link{apply}}, but
\code{splitter_a} just splits up the data, while \code{apply} also
applies a function and combines the pieces back together.  This function
also includes enough information to recreate the split from attributes on
the list of pieces.}

\examples{splitter_a(mtcars, 1)
splitter_a(mtcars, 2)

splitter_a(ozone, 2)
splitter_a(ozone, 3)
splitter_a(ozone, 1:2)}

