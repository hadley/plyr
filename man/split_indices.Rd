\name{split_indices}
\alias{split_indices}
\title{Split indices.}
\usage{split_indices(index, group, n=max(group))}

\description{
  Split indices. An optimised version of split for the special case of
  splitting row indices into groups, as used by
  \code{\link{splitter_d}}
}
\keyword{internal}
\keyword{manip}
\arguments{
  \item{index}{integer indices}
  \item{group}{integer groups}
  \item{n}{largest integer (may not appear in index)}
}
