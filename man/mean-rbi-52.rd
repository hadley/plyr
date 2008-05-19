\name{mean_rbi}
\alias{mean_rbi}
\title{X mean_rbi <- function(df) mean(df$rbi, na.rm=T)}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
X rbi <- ddply(baseball, .(year), mean_rbi)
}
\usage{mean_rbi(df)}
\arguments{
\item{df}{}
}

\details{}

\examples{mean_rbi <- function(df) mean(df$rbi, na.rm=T)
rbi <- ddply(baseball, .(year), mean_rbi)
with(rbi, plot(year, V1, type="l"))

ddply(baseball, .(year), numcolwise(mean), na.rm=TRUE)
base2 <- ddply(baseball, .(id), function(df) {
transform(df, career_year = year - min(year) + 1)
})}

