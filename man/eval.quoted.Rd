\name{eval.quoted}
\alias{eval.quoted}
\title{Evaluate a quoted list of variables.}
\usage{
  eval.quoted(exprs, envir = NULL, enclos = NULL, try =
  FALSE)
}
\arguments{
  \item{expr}{quoted object to evalution}

  \item{try}{if TRUE, return \code{NULL} if evaluation
  unsuccesful}
}
\value{
  a list
}
\description{
  Evaluates quoted variables in specified environment
}
\keyword{internal}

