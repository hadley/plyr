\name{failwith}
\alias{failwith}
\title{Fail with}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
Modify a function so that it returns a default value when there is an error.
}
\usage{failwith(default = NULL, f, quiet = FALSE)}
\arguments{
\item{default}{default value}
\item{f}{function}
\item{quiet}{}
}
\value{a function}
\details{}
\seealso{\code{\link{try_default}}}
\examples{f <- function(x) if (x == 1) stop("Error!") else 1
\dontrun{
f(1)
f(2)
}

safef <- failwith(NULL, f)
safef(1)
safef(2) }
\keyword{debugging}
