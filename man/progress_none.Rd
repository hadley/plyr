\name{progress_none}
\alias{progress_none}
\title{Null progress bar}
\description{
  A progress bar that does nothing
}
\details{
  This the default progress bar used by plyr functions.
  It's very simple to understand - it does nothing!
}
\examples{
l_ply(1:100, identity, .progress = "none")
}
\seealso{
  Other progress bars: \code{\link{progress_text}},
  \code{\link{progress_tk}}, \code{\link{progress_win}}
}
\keyword{internal}

