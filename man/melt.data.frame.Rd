\name{melt.data.frame}
\alias{melt.data.frame}
\title{Melt a data frame...}
\usage{\method{melt}{data.frame} (data, id.vars, measure.vars,
    variable.name="variable", value.name="value", na.rm=FALSE, ...)}

\description{
  Melt a data frame Melt a data frame into form suitable for easy
  casting.
}

\details{
  You need to tell melt which of your variables are id variables, and
  which are measured variables. If you only supply one of
  \code{id.vars} and \code{measure.vars}, melt will assume the
  remainder of the variables in the data set belong to the other. If
  you supply neither, melt will assume factor and character variables
  are id variables, and all others are measured.
}
\keyword{manip}
\arguments{
  \item{data}{data frame to melt}
  \item{id.vars}{vector of id variables. Can be integer (variable position)
or string (variable name)If blank, will use all non-measured variables.}
  \item{measure.vars}{vector of measured variables. Can be integer (variable
position) or string (variable name)If blank, will use all non id.vars}
  \item{variable.name}{name of variable used to store measured variable names}
  \item{value.name}{name of variable used to store values}
  \item{na.rm}{Should NA values be removed from the data set? This will 
convert explicit missings to implicit missings.}
  \item{...}{further arguments passed to or from other methods.}
}
\examples{names(airquality) <- tolower(names(airquality))
melt(airquality, id=c("month", "day"))
names(ChickWeight) <- tolower(names(ChickWeight))
melt(ChickWeight, id=2:4)}
