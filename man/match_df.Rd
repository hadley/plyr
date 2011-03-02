\name{match_df}
\alias{match_df}
\title{Extract matching rows of a data frame.}
\usage{match_df(x, y, on)}

\description{
  Extract matching rows of a data frame.
}

\details{
  This is particularly useful when you've summarised the
  data in some way and want to subset the original data by
  a characteristic of the subset.
}
\value{a data frame}
\seealso{\code{\link{join}} to combine the columns from both x and y}
\arguments{
  \item{x}{data frame to subset.}
  \item{y}{data frame defining matching rows.}
  \item{on}{variables to match on - by default will use all variables common
to both data frames.}
}
\examples{longterm <- subset(count(baseball, "id"), freq > 25)
bb_longterm <- match_df(baseball, longterm)}
