\name{progress_text}
\alias{progress_text}
\title{Text progress bar}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
A textual progress bar
}
\usage{progress_text(style = 3, ...)}
\arguments{
\item{style}{}
\item{...}{}
}

\details{This progress bar displays a textual progress bar that works on all
platforms.  It is a thin wrapper around the built-in
\code{\link{setTxtProgressBar}} and can be customised in the same way.}

\examples{l_ply(1:1000, identity, progress. = "text")
l_ply(1:1000, identity, progress. = progress_text(char = "-"))}

