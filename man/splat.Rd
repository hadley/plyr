\name{splat}
\alias{splat}
\title{`Splat' arguments to a function.}
\usage{splat(flat)}

\description{
  `Splat' arguments to a function. Wraps a function in
  do.call
}

\details{
  This is useful when you want to pass a function a row of
  data frame or array, and don't want to manually pull it
  apart in your function.
}
\value{a function}
\arguments{
  \item{flat}{function to splat}
}
\examples{hp_per_cyl <- function(hp, cyl, ...) hp / cyl
splat(hp_per_cyl)(mtcars[1,])
splat(hp_per_cyl)(mtcars)

f <- function(mpg, wt, ...) data.frame(mw = mpg / wt)
ddply(mtcars, .(cyl), splat(f))}
