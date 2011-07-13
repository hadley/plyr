\name{match_df}
\alias{match_df}
\title{Extract matching rows of a data frame.}
\usage{
  match_df(x, y, on = NULL)
}
\arguments{
  \item{x}{data frame to subset.}

  \item{y}{data frame defining matching rows.}

  \item{on}{variables to match on - by default will use all
  variables common to both data frames.}
}
\value{
  a data frame
}
\description{
  This is particularly useful when you've summarised the
  data in some way and want to subset the original data by
  a characteristic of the subset.
}
\examples{
longterm <- subset(count(baseball, "id"), freq > 25)
bb_longterm <- match_df(baseball, longterm)
}
\seealso{
  \code{\link{join}} to combine the columns from both x and
  y
}

