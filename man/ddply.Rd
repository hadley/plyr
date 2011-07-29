\name{ddply}
\alias{ddply}
\title{Split data frame, apply function, and return results in a data frame.}
\usage{
  ddply(.data, .variables, .fun = NULL, ..., .progress =
  "none", .drop = TRUE, .parallel = FALSE)
}
\arguments{
  \item{.fun}{function to apply to each piece}

  \item{...}{other arguments passed on to \code{.fun}}

  \item{.progress}{name of the progress bar to use, see
  \code{\link{create_progress_bar}}}

  \item{.data}{data frame to be processed}

  \item{.variables}{variables to split data frame by, as
  quoted variables, a formula or character vector}

  \item{.drop}{should combinations of variables that do not
  appear in the input data be preserved (FALSE) or dropped
  (TRUE, default)}

  \item{.parallel}{if \code{TRUE}, apply function in
  parallel, using parallel backend provided by foreach}
}
\value{
  A data frame, as described in the output section.
}
\description{
  For each subset of a data frame, apply function then
  combine results into a data frame.
}
\section{Input}{
  This function splits data frames by variables.
}

\section{Output}{
  The most unambiguous behaviour is achieved when
  \code{.fun} returns a data frame - in that case pieces
  will be combined with \code{\link{rbind.fill}}.  If
  \code{.fun} returns an atomic vector of fixed length, it
  will be \code{rbind}ed together and converted to a data
  frame. Any other values will result in an error.

  If there are no results, then this function will return a
  data frame with zero rows and columns
  (\code{data.frame()}).
}
\examples{
ddply(baseball, .(year), "nrow")
ddply(baseball, .(lg), c("nrow", "ncol"))

rbi <- ddply(baseball, .(year), summarise,
mean_rbi = mean(rbi, na.rm = TRUE))
with(rbi, plot(year, mean_rbi, type="l"))

base2 <- ddply(baseball, .(id), transform,
career_year = year - min(year) + 1
)
}
\references{
  Hadley Wickham (2011). The Split-Apply-Combine Strategy
  for Data Analysis. Journal of Statistical Software,
  40(1), 1-29. \url{http://www.jstatsoft.org/v40/i01/}.
}
\seealso{
  Other data frame input: \code{\link{daply}},
  \code{\link{dlply}}

  Other data frame output: \code{\link{adply}},
  \code{\link{ldply}}
}
\keyword{manip}

