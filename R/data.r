#' Monthly ozone measurements over Central America.
#'
#'
#' This data set is a subset of the data from the 2006 ASA Data expo
#' challenge, \url{http://stat-computing.org/dataexpo/2006/}. The data are
#' monthly ozone averages on a very coarse 24 by 24 grid covering Central
#' America, from Jan 1995 to Dec 2000. The data is stored in a 3d area with
#' the first two dimensions representing latitude and longitude, and the third
#' representing time.
#'
#' @docType data
#' @name ozone
#' @usage ozone
#' @format A 24 x 24 x 72 numeric array
#' @references \url{http://stat-computing.org/dataexpo/2006/}
#' @keywords datasets
#' @examples
#' value <- ozone[1, 1, ]
#' time <- 1:72
#' month.abbr <- c("Jan", "Feb", "Mar", "Apr", "May",
#'  "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
#' month <- factor(rep(month.abbr, length = 72), levels = month.abbr)
#' year <- rep(1:6, each = 12)
#' deseasf <- function(value) lm(value ~ month - 1)
#'
#' models <- alply(ozone, 1:2, deseasf)
#' coefs <- laply(models, coef)
#' dimnames(coefs)[[3]] <- month.abbr
#' names(dimnames(coefs))[3] <- "month"
#'
#' deseas <- laply(models, resid)
#' dimnames(deseas)[[3]] <- 1:72
#' names(dimnames(deseas))[3] <- "time"
#'
#' dim(coefs)
#' dim(deseas)
NULL

#' Yearly batting records for all major league baseball players
#'
#' This data frame contains batting statistics for a subset of players
#' collected from \url{http://www.baseball-databank.org/}. There are a total
#' of 21,699 records, covering 1,228 players from 1871 to 2007. Only players
#' with more 15 seasons of play are included.
#'
#' @section Variables:
#' Variables:
#' \itemize{
#'  \item id, unique player id
#'  \item year, year of data
#'  \item stint
#'  \item team, team played for
#'  \item lg, league
#'  \item g, number of games
#'  \item ab, number of times at bat
#'  \item r, number of runs
#'  \item h, hits, times reached base because of a batted, fair ball without
#'      error by the defense
#'  \item X2b, hits on which the batter reached second base safely
#'  \item X3b, hits on which the batter reached third base safely
#'  \item hr, number of home runs
#'  \item rbi, runs batted in
#'  \item sb, stolen bases
#'  \item cs, caught stealing
#'  \item bb, base on balls (walk)
#'  \item so, strike outs
#'  \item ibb, intentional base on balls
#'  \item hbp, hits by pitch
#'  \item sh, sacrifice hits
#'  \item sf, sacrifice flies
#'  \item gidp, ground into double play
#' }
#' @docType data
#' @name baseball
#' @usage baseball
#' @format A 21699 x 22 data frame
#' @references \url{http://www.baseball-databank.org/}
#' @keywords datasets
#' @examples
#' baberuth <- subset(baseball, id == "ruthba01")
#' baberuth$cyear <- baberuth$year - min(baberuth$year) + 1
#'
#' calculate_cyear <- function(df) {
#'   mutate(df,
#'     cyear = year - min(year),
#'     cpercent = cyear / (max(year) - min(year))
#'   )
#' }
#'
#' baseball <- ddply(baseball, .(id), calculate_cyear)
#' baseball <- subset(baseball, ab >= 25)
#'
#' model <- function(df) {
#'   lm(rbi / ab ~ cyear, data=df)
#' }
#' model(baberuth)
#' models <- dlply(baseball, .(id), model)
NULL
