\name{indexed_df}
\alias{"[.indexed"}
\alias{"[[.indexed_df"}
\alias{as.list.indexed}
\alias{indexed_df}
\alias{length.indexed}
\alias{names.indexed}
\alias{print.indexed}
\title{An indexed data frame.}
\usage{
  indexed_df(data, index, vars)
}
\arguments{
  \item{env}{environment containing data frame}

  \item{index}{list of indices}

  \item{vars}{a character vector giving the variables used
  for subsetting}
}
\description{
  Create a indexed list, a space efficient way of indexing
  into a large data frame
}
\keyword{internal}

