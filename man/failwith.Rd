\name{failwith}
\alias{failwith}
\title{Fail with specified value.}
\usage{failwith(default, f, quiet=FALSE)}

\description{
  Fail with specified value.
}

\details{
  Modify a function so that it returns a default value when
  there is an error.
}
\value{a function}
\seealso{\code{\link{try_default}}}
\keyword{debugging}
\arguments{
  \item{default}{default value}
  \item{f}{function}
  \item{quiet}{all error messages be suppressed?}
}
\examples{f <- function(x) if (x == 1) stop("Error!") else 1
\dontrun{
f(1)
f(2)
}

safef <- failwith(NULL, f)
safef(1)
safef(2)}
