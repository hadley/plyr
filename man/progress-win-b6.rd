\name{progress_win}
\alias{progress_win}
\title{Graphical progress bar, powered by Windows}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
A graphical progress bar displayed in a separate window
}
\usage{progress_win(title = "plyr progress", ...)}
\arguments{
\item{title}{window title}
\item{...}{other arguments passed on to \code{\link[utils]{winProgressBar}}}
}

\details{This graphical progress only works on Windows.}
\seealso{\code{\link[utils]{winProgressBar}} for the function that powers this progress bar}
\examples{if(exists("winProgressBar")) {
l_ply(1:1000, identity, .progress = "win")
l_ply(1:1000, identity, .progress = progress_win(title="Working..."))
}}

