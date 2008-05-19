\name{linmod}
\alias{linmod}
\title{X linmod <- function(df) lm(rbi ~ year, data = transform(df, year = year - min(year)))}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
X models <- dlply(baseball, .(id), linmod)
}
\usage{linmod(df)}
\arguments{
\item{df}{}
}

\details{}

\examples{linmod <- function(df) lm(rbi ~ year, data = transform(df, year = year - min(year)))
models <- dlply(baseball, .(id), linmod)
models[[1]]

coef <- ldply(models, coef)
with(coef, plot(`(Intercept)`, year))
qual <- ldply(models, function(mod) summary(mod)$r.squared )
hist(qual)}

