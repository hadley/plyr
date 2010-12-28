\name{mutate}
\alias{mutate}
\title{Mutate a data frame by adding new columns or replacing existing.}
\usage{mutate(.data, ...)}

\description{
  Mutate a data frame by adding new columns or replacing
  existing.
}

\details{
  This function is very similar to \code{\link{transform}}
  but it executes the transformations iteratively so that
  later transformations can use the columns created by
  earlier transformations.  Like transform, unnamed
  components are silently dropped.

  Mutate seems to be considerably faster than transform for
  large data frames.
}
\seealso{\code{\link{subset}}, \code{\link{summarise}},
\code{\link{arrange}}}
\arguments{
  \item{.data}{the data frame to transform}
  \item{...}{named parameters giving definitions of new columns.}
}
\examples{# Examples from transform
mutate(airquality, Ozone = -Ozone)
mutate(airquality, new = -Ozone, Temp = (Temp - 32) / 1.8)

# Things transform can't do
mutate(airquality, Temp = (Temp - 32) / 1.8, OzT = Ozone / Temp) 

# mutate is rather faster than transform
system.time(transform(baseball, avg_ab = ab / g))
system.time(mutate(baseball, avg_ab = ab / g))}
