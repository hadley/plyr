\name{.}
\alias{.}
\alias{quoted}
\title{Quote variables}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
Create a list of unevaluated expressions for later evaluation
}
\usage{.(...)}
\arguments{
\item{...}{unevaluated expressions to be recorded.  Specify names if you want the set the names of the resultant variables}
}
\value{list of symbol and language primitives}
\details{This function is similar to \code{\link{~}} in that it is used to
capture the name of variables, not their current value.  This is used
throughout plyr to specify the names of variables (or more complicated
expressions).

Similar tricks can be performed with \code{\link{substitute}}, but when
functions can be called in multiple ways it becomes increasingly tricky
to ensure that the values are extracted from the correct frame.  Substitute
tricks also make it difficult to program against the functions that use
them, while the \code{quoted} class provides
\code{\link{as.quoted.character}} to convert strings to the appropriate
data structure.}

\examples{.(a, b, c)
.(first = a, second = b, third = c)
.(a ^ 2, b - d, log(c))
as.quoted(~ a + b + c)
as.quoted(a ~ b + c)
as.quoted(c("a", "b", "c"))

# Some examples using ddply - look at the column names
ddply(mtcars, "cyl", each(nrow, ncol))
ddply(mtcars, ~ cyl, each(nrow, ncol))
ddply(mtcars, .(cyl), each(nrow, ncol))
ddply(mtcars, .(log(cyl)), each(nrow, ncol))
ddply(mtcars, .(logcyl = log(cyl)), each(nrow, ncol))
ddply(mtcars, .(vs + am), each(nrow, ncol))
ddply(mtcars, .(vsam = vs + am), each(nrow, ncol))}

