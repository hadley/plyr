% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/m_ply.r
\name{m_ply}
\alias{m_ply}
\title{Call function with arguments in array or data frame, discarding results.}
\usage{
m_ply(
  .data,
  .fun = NULL,
  ...,
  .expand = TRUE,
  .progress = "none",
  .inform = FALSE,
  .print = FALSE,
  .parallel = FALSE,
  .paropts = NULL
)
}
\arguments{
\item{.data}{matrix or data frame to use as source of arguments}

\item{.fun}{function to apply to each piece}

\item{...}{other arguments passed on to \code{.fun}}

\item{.expand}{should output be 1d (expand = FALSE), with an element for
each row; or nd (expand = TRUE), with a dimension for each variable.}

\item{.progress}{name of the progress bar to use, see
\code{\link{create_progress_bar}}}

\item{.inform}{produce informative error messages?  This is turned off
by default because it substantially slows processing speed, but is very
useful for debugging}

\item{.print}{automatically print each result? (default: \code{FALSE})}

\item{.parallel}{if \code{TRUE}, apply function in parallel, using parallel
backend provided by foreach}

\item{.paropts}{a list of additional options passed into
the \code{\link[foreach]{foreach}} function when parallel computation
is enabled.  This is important if (for example) your code relies on
external data or packages: use the \code{.export} and \code{.packages}
arguments to supply them so that all cluster nodes have the correct
environment set up for computing.}
}
\value{
Nothing
}
\description{
Call a multi-argument function with values taken from columns of an
data frame or array, and discard results into a list.
}
\details{
The \code{m*ply} functions are the \code{plyr} version of \code{mapply},
specialised according to the type of output they produce.  These functions
are just a convenient wrapper around \code{a*ply} with \code{margins = 1}
and \code{.fun} wrapped in \code{\link{splat}}.
}
\section{Input}{
 Call a multi-argument function with values taken from
  columns of an data frame or array
}

\section{Output}{

  All output is discarded. This is useful for functions that you are
  calling purely for their side effects like displaying plots or
  saving output.
}

\references{
Hadley Wickham (2011). The Split-Apply-Combine Strategy
  for Data Analysis. Journal of Statistical Software, 40(1), 1-29.
  \url{https://www.jstatsoft.org/v40/i01/}.
}
\seealso{
Other multiple arguments input: 
\code{\link{maply}()},
\code{\link{mdply}()},
\code{\link{mlply}()}

Other no output: 
\code{\link{a_ply}()},
\code{\link{d_ply}()},
\code{\link{l_ply}()}
}
\concept{multiple arguments input}
\concept{no output}
\keyword{manip}
