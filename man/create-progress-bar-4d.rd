\name{create_progress_bar}
\alias{create_progress_bar}
\title{Create progress bar}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
Create progress bar object from text string.
}
\usage{create_progress_bar(name = "none")}
\arguments{
\item{name}{type of progress bar to create}
}

\details{Progress bars give feedback on how apply step is proceeding.  This
is mainly useful for long running functions, as for short functions, the
time taken up by splitting and combining may be on the same order (or
longer) as the apply step.  Additionally, for short functions, the time
needed to update the progress bar can significantly slow down the process.
For the trivial examples below, using the tk progress bar slows things down
by a factor of a thousand.

Note the that progress bar is approximate, and if the time taken by
individual function applications is highly non-uniform it may not be very
informative of the time left.

There are currently four types of progress bar:  "none", "text", "tk", and
"win".  See the individual documentation for more details.  In plyr
functions, these can either be specified by name, or you can create the
progress bar object yourself if you want more control over its apperance.
See the examples.}
\seealso{\code{\link{progress_none}}, \code{\link{progress_text}}, \code{\link{progress_tk}}, \code{\link{progress_win}}}
\examples{l_ply(1:1000, identity, progress. = "none")
l_ply(1:1000, identity, progress. = "tk")
l_ply(1:1000, identity, progress. = "text")
l_ply(1:1000, identity, progress. = progress_text(char = "-"))}

