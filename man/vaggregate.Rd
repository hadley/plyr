\name{vaggregate}
\alias{vaggregate}
\title{Vector aggregate.}
\usage{vaggregate(.value, .group, .fun, ..., .default, .n=max(group))}

\description{
  Vector aggregate.
}

\details{
  This function is somewhat similar to \code{tapply}, but is designed
  for use in conjunction with \code{id}.
}
\arguments{
  \item{.value}{vector of values to aggregate}
  \item{.group}{grouping vector}
  \item{.fun}{aggregation function}
  \item{...}{other arguments passed on to \code{.fun}}
  \item{.default}{default value used for missing groups.  This argument is 
also used as the template for function output.}
  \item{.n}{total number of groups}
}
