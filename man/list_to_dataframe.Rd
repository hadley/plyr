\name{list_to_dataframe}
\alias{list_to_dataframe}
\title{List to data frame.}
\usage{list_to_dataframe(res, labels)}

\description{
  List to data frame. Reduce/simplify a list of homogenous objects to a
  data frame. All \code{NULL} entries are removed. Remaining entries
  must be all atomic or all data frames.
}
\keyword{internal}
\arguments{
  \item{res}{list of input data}
  \item{labels}{a data frame of labels, one row for each element of res}
}
