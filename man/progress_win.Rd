\name{progress_win}
\alias{progress_win}
\title{Graphical progress bar, powered by Windows.}
\usage{progress_win(title="plyr progress", ...)}

\description{
  Graphical progress bar, powered by Windows. A graphical progress bar
  displayed in a separate window
}

\details{
  This graphical progress only works on Windows.
}
\seealso{\code{winProgressBar} for the function that powers this progress bar}
\arguments{
  \item{title}{window title}
  \item{...}{other arguments passed on to \code{winProgressBar}}
}
\examples{if(exists("winProgressBar")) {
l_ply(1:1000, identity, .progress = "win")
l_ply(1:1000, identity, .progress = progress_win(title="Working..."))
}}
