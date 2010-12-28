\name{progress_none}
\alias{progress_none}
\title{Null progress bar...}

\description{
  Null progress bar A progress bar that does nothing
}

\details{
  This the default progress bar used by plyr functions.
  It's very simple to understand - it does nothing!
}
\keyword{internal}
\examples{l_ply(1:100, identity, .progress = "none")}
