\name{eval.quoted}
\alias{eval.quoted}
\title{Evaluate a quoted list of variables...}
\usage{eval.quoted(exprs, envir=parent.frame(), enclos=if (is.list(envir) ||
    is.pairlist(envir)) parent.frame() else baseenv())}

\description{
  Evaluate a quoted list of variables Evaluates quoted variables in
  specified environment
}
\value{a list}
\keyword{internal}
