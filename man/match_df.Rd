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
# count the occurrences of each id in the baseball dataframe, then get the subset with a freq >25
longterm <- subset(count(baseball, "id"), freq > 25)
# longterm
#             id freq
# 30   ansonca01   27
# 48   baineha01   27
# ...
# Select only rows from these longterm players from the baseball dataframe
# (match would default to match on shared column names, but here was explicitly set "id")
bb_longterm <- match_df(baseball, longterm, on="id")
bb_longterm[1:5,]
}
\seealso{
  \code{\link{join}} to combine the columns from both x and
  y and \code{\link{match}} for the base function selecting
  matching items
}

