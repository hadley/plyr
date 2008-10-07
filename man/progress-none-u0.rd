\name{progress_none}
\alias{progress_none}
\title{Null progress bar}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
A progress bar that does nothing
}
\usage{progress_none()}
\arguments{

}

\details{This the default progress bar used by plyr functions.  It's very simple to
understand - it does nothing!}

\examples{l_ply(1:100, identity, .progress = "none")}

