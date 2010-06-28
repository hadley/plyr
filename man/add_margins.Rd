\name{add_margins}
\alias{add_margins}
\title{Add margins to a data frame.}
\usage{add_margins(df, rows, cols, margins=TRUE)}

\description{
  Add margins to a data frame.
}

\details{
  Rownames are silently stripped. All margining variables will be
  converted to factors.
}
\arguments{
  \item{df}{input data frame}
  \item{rows}{names of row margins}
  \item{cols}{names of column margins}
  \item{margins}{Either \code{TRUE} to compute all margins, or a character
vector of margin names, which may include any name in \code{rows} or
\code{cols}, or \code{"grand_row"} or \code{"grand_col"}.}
}
