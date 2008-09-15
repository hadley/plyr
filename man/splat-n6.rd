\name{splat}
\alias{splat}
\title{`Splat' arguments to a function}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
Wraps a function in do.call
}
\usage{splat(flat)}
\arguments{
\item{flat}{function to splat}
}
\value{a function}
\details{This is useful when you want to pass a function a row of data frame or
array, and don't want to manually pull it apart in your function.}

\examples{hp_per_cyl <- function(hp, cyl, ...) hp / cyl
splat(hp_per_cyl)(mtcars[1,])
splat(hp_per_cyl)(mtcars)

f <- function(mpg, wt, ...) data.frame(mw = mpg / wt)
ddply(mtcars, .(cyl), splat(f))}

