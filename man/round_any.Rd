\name{round_any}
\alias{round_any}
\title{Round to multiple of any number...}
\usage{round_any(x, accuracy, f=round)}

\description{
  Round to multiple of any number
}
\keyword{manip}
\arguments{
  \item{x}{numeric vector to round}
  \item{accuracy}{number to round to}
  \item{f}{rounding function: \code{\link{floor}}, \code{\link{ceiling}} or 
\code{\link{round}}}
}
\examples{round_any(135, 10)
round_any(135, 100)
round_any(135, 25)
round_any(135, 10, floor)
round_any(135, 100, floor)
round_any(135, 25, floor)
round_any(135, 10, ceiling)
round_any(135, 100, ceiling)
round_any(135, 25, ceiling)}
