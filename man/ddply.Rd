\name{ddply}
\alias{ddply}
\title{Split data frame, apply function, and return results in a data frame.}
\usage{ddply(.data, .variables, .fun, ..., .progress="none", .drop=TRUE,
    .parallel=FALSE)}

\description{
  Split data frame, apply function, and return results in a data frame.
  For each subset of a data frame, apply function then combine results
  into a data frame
}

\details{
  All plyr functions use the same split-apply-combine strategy: they
  split the input into simpler pieces, apply \code{.fun} to each piece,
  and then combine the pieces into a single data structure.  This
  function splits data frames by variables and combines the result into
  a data frame.  If there are no results, then this function will
  return a data frame with zero rows and columns (\code{data.frame()}).

  The most unambiguous behaviour is achieved when \code{.fun} returns a
  data frame - in that case pieces will be combined with
  \code{\link{rbind.fill}}.  If \code{.fun} returns an atomic vector of
  fixed length, it will be \code{rbind}ed together and converted to a
  data frame. Any other values will result in an error.
}
\keyword{manip}
\value{a data frame}
\arguments{
  \item{.data}{data frame to be processed}
  \item{.variables}{variables to split data frame by, as quoted variables, a formula or character vector}
  \item{.fun}{function to apply to each piece}
  \item{.drop}{should combinations of variables that do not appear in the 
data be preserved (FALSE) or dropped (TRUE, default)}
  \item{...}{other arguments passed on to \code{.fun}}
  \item{.progress}{name of the progress bar to use, see \code{\link{create_progress_bar}}}
  \item{.parallel}{if \code{TRUE}, apply function in parallel, using parallel 
backend provided by foreach}
}
\examples{ddply(baseball, .(year), "nrow") 
ddply(baseball, .(lg), c("nrow", "ncol")) 

rbi <- ddply(baseball, .(year), summarise, 
mean_rbi = mean(rbi, na.rm = TRUE))
with(rbi, plot(year, mean_rbi, type="l"))

base2 <- ddply(baseball, .(id), transform, 
career_year = year - min(year) + 1
)}
