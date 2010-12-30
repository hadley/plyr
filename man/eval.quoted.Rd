\name{eval.quoted}
\alias{eval.quoted}
\title{Evaluate a quoted list of variables.}
\usage{eval.quoted(exprs, envir, enclos, try=FALSE)}

\description{
  Evaluate a quoted list of variables. Evaluates quoted
  variables in specified environment
}
\value{a list}
\keyword{internal}
\arguments{
  \item{expr}{quoted object to evalution}
  \item{try}{if TRUE, return \code{NULL} if evaluation unsuccesful}
}
