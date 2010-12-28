\name{Baseball batting}
\docType{data}
\alias{baseball}
\title{Yearly batting records for all major league baseball players}
\description{

This data frame contains batting statistics for a subset of players collected from \url{http://www.baseball-databank.org/}. There are a total of 21,699 records, covering 1,228 players from 1871 to 2007. Only players with more 15 seasons of play are included.

Variables:

\itemize{
\item id, unique player id
\item year, year of data
\item stint
\item team, team played for
\item lg, league
\item g, number of games
\item ab, number of times at bat
\item r, number of runs
\item h, hits, times reached base because of a batted, fair ball without error by the defense
\item X2b, hits on which the batter reached second base safely
\item X3b, hits on which the batter reached third base safely 
\item hr, number of home runs
\item rbi, runs batted in
\item sb, stolen bases
\item cs, caught stealing
\item bb, base on balls (walk)
\item so, strike outs
\item ibb, intentional base on balls
\item hbp, hits by pitch
\item sh, sacrifice hits
\item sf, sacrifice flies
\item gidp, ground into double play
}
}
\usage{data(baseball)}
\format{A 21699 x 22 data frame}
\references{\url{http://www.baseball-databank.org/}}
\keyword{datasets}
\examples{

baberuth <- subset(baseball, id == "ruthba01")
baberuth$cyear <- baberuth$year - min(baberuth$year) + 1

calculate_cyear <- function(df) {
  mutate(df, 
    cyear = year - min(year),
    cpercent = cyear / (max(year) - min(year))
  )
}

baseball <- ddply(baseball, .(id), calculate_cyear)
baseball <- subset(baseball, ab >= 25)

model <- function(df) {
  lm(rbi / ab ~ cyear, data=df)
}
model(baberuth)
models <- dlply(baseball, .(id), model)
}
