\name{rename}
\alias{rename}
\title{Modify names by name, not position.}
\usage{
  rename(x, replace)
}
\arguments{
  \item{x}{named object to modify}

  \item{replace}{named character vector, with new names as
  values, and old names as names.}
}
\description{
  Modify names by name, not position.
}
\examples{
x <- c("a" = 1, "b" = 2, d = 3, 4)
rename(x, c("d" = "c"))
rename(mtcars, c("disp" = "displ"))
}

