\name{melt_check}
\alias{melt_check}
\title{Check that input variables to melt are appropriate.}
\usage{melt_check(data, id.vars, measure.vars)}

\description{
  Check that input variables to melt are appropriate.
}

\details{
  If id.vars or measure.vars are missing, \code{melt_check} will do its
  best to impute them. If you only supply one of id.vars and
  measure.vars, melt will assume the remainder of the variables in the
  data set belong to the other. If you supply neither, melt will assume
  discrete variables are id variables and all other are measured.
}
\value{a list giving id and measure variables names.}
\arguments{
  \item{data}{data frame}
  \item{id.vars}{vector of identifying variable names or indexes}
  \item{measure.vars}{vector of Measured variable names or indexes}
}
