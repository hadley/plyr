\name{vaggregate}
\alias{vaggregate}
\title{Vector aggregate.}
\usage{vaggregate(.value, .group, .fun, ..., .default, .n=max(group))}

\description{
  Vector aggregate.
}
\arguments{
  \item{.value}{vector of values to aggregate}
  \item{.group}{grouping vector}
  \item{.fun}{aggregation function}
  \item{...}{other arguments passed on to \code{.fun}}
  \item{.default}{default value used for missing groups}
  \item{.n}{total number of groups}
}
