\name{raply}
\alias{raply}
\title{Replicate expression and return results in a array}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
Evalulate expression n times then combine results into an array
}
\usage{raply(.n, .expr, .progress = "none", .drop = TRUE)}
\arguments{
\item{.n}{number of times to evaluate the expression}
\item{.expr}{expression to evaluate}
\item{.progress}{name of the progress bar to use, see \code{\link{create_progress_bar}}}
\item{.drop}{}
}
\value{if results are atomic with same type and dimensionality, a vector, matrix or array; otherwise, a list-array (a list with dimensions)}
\details{This function runs an expression multiple times, and combines the
result into a data frame.  If there are no results, then this function
returns a vector of length 0 (\code{vector(0)}).
This function is equivalent to \code{\link{replicate}}, but will always
return results as a vector, matrix or array.


@keyword manip
@arguments number of times to evaluate the expression
@arguments expression to evaluate
@arguments name of the progress bar to use, see \code{\link{create_progress_bar}}
@value if results are atomic with same type and dimensionality, a vector, matrix or array; otherwise, a list-array (a list with dimensions)}

\examples{raply(100, mean(runif(100)))
raply(100, each(mean, var)(runif(100)))

raply(10, runif(4))
raply(10, matrix(runif(4), nrow=2))

# See the central limit theorem in action
hist(raply(1000, mean(rexp(10))))
hist(raply(1000, mean(rexp(100))))
hist(raply(1000, mean(rexp(1000))))}
\keyword{manip}
