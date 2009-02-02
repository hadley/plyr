\name{rlply}
\alias{rlply}
\title{Replicate expression and return results in a list}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
Evalulate expression n times then combine results into a list
}
\usage{rlply(.n, .expr, .progress = "none")}
\arguments{
\item{.n}{number of times to evaluate the expression}
\item{.expr}{expression to evaluate}
\item{.progress}{name of the progress bar to use, see \code{\link{create_progress_bar}}}
}
\value{list of results}
\details{This function runs an expression multiple times, and combines the
result into a list.  If there are no results, then this function will return
a list of length 0  (\code{list()}). This function is equivalent to
\code{\link{replicate}}, but will always return results as a list.


@keyword manip
@arguments number of times to evaluate the expression
@arguments expression to evaluate
@arguments name of the progress bar to use, see \code{\link{create_progress_bar}}
@value list of results}

\examples{mods <- rlply(100, lm(y ~ x, data=data.frame(x=rnorm(100), y=rnorm(100))))
hist(laply(mods, function(x) summary(x)$r.squared))}
\keyword{manip}
