% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dlply.r
\name{dlply}
\alias{dlply}
\title{Split data frame, apply function, and return results in a list.}
\usage{
dlply(
  .data,
  .variables,
  .fun = NULL,
  ...,
  .progress = "none",
  .inform = FALSE,
  .drop = TRUE,
  .parallel = FALSE,
  .paropts = NULL
)
}
\arguments{
\item{.data}{data frame to be processed}

\item{.variables}{variables to split data frame by, as \code{\link{as.quoted}}
variables, a formula or character vector}

\item{.fun}{function to apply to each piece}

\item{...}{other arguments passed on to \code{.fun}}

\item{.progress}{name of the progress bar to use, see
\code{\link{create_progress_bar}}}

\item{.inform}{produce informative error messages?  This is turned off
by default because it substantially slows processing speed, but is very
useful for debugging}

\item{.drop}{should combinations of variables that do not appear in the
input data be preserved (FALSE) or dropped (TRUE, default)}

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
list of results
}
\description{
For each subset of a data frame, apply function then combine results into a
list. \code{dlply} is similar to \code{\link{by}} except that the results
are returned in a different format.
To apply a function for each row, use \code{\link{alply}} with
\code{.margins} set to \code{1}.
}
\section{Input}{
 This function splits data frames by variables.
}

\section{Output}{
 If there are no results, then this function will return
  a list of length 0 (\code{list()}).
}

\examples{
linmod <- function(df) {
  lm(rbi ~ year, data = mutate(df, year = year - min(year)))
}
models <- dlply(baseball, .(id), linmod)
models[[1]]

coef <- ldply(models, coef)
with(coef, plot(`(Intercept)`, year))
qual <- laply(models, function(mod) summary(mod)$r.squared)
hist(qual)
}
\references{
Hadley Wickham (2011). The Split-Apply-Combine Strategy
  for Data Analysis. Journal of Statistical Software, 40(1), 1-29.
  \url{https://www.jstatsoft.org/v40/i01/}.
}
\seealso{
Other data frame input: 
\code{\link{d_ply}()},
\code{\link{daply}()},
\code{\link{ddply}()}

Other list output: 
\code{\link{alply}()},
\code{\link{llply}()},
\code{\link{mlply}()}
}
\concept{data frame input}
\concept{list output}
\keyword{manip}
