library(ggplot2)
library(plyr)
options(digits=3)
source("ozone-map.r")
brightblue <- rgb(102,204,255, max=255)

# Base ball case study ============================================
baberuth <- subset(baseball, id == "ruthba01")
baberuth$cyear <- baberuth$year - min(baberuth$year) + 1

calculate_cyear <- function(df) {
  transform(df, 
    cyear = year - min(year),
    cpercent = (year - min(year)) / (max(year) - min(year))
  )
}

baseball <- ddply(baseball, .(id), calculate_cyear)
baseball <- subset(baseball, ab >= 25)

# Runs per bat for Babe Ruth.
qplot(cyear, rbi / ab, data=baberuth, geom="line")

xlim <- range(baseball$cyear, na.rm=TRUE)
ylim <- range(baseball$rbi / baseball$ab, na.rm=TRUE)
plotpattern <- function(df) {
  qplot(cyear, rbi / ab, data = df, geom="line", xlim = xlim, ylim = ylim)
}

pdf("paths.pdf", width=8, height=4)
d_ply(baseball, .(reorder(id, rbi / ab)), failwith(NA, plotpattern), 
  print. = TRUE)
dev.off()

model <- function(df) {
  lm(rbi / ab ~ cyear, data=df)
}
model(baberuth)
models <- dlply(baseball, .(id), model)

rsq <- function(x) summary(x)$r.squared
coef <- ldply(models, function(x) c(coef(x), rsq(x)))
names(coef) <- c("id", "intercept", "slope", "rsquare")

# Histogram of model r-squared with bin width of 0.05.  Most models fit
# very poorly! The spike of models with a r-squared of 1 are players
# with only two data points, found by inspecting {\tt
# ldply(models[coef\$rsquare == 1], "[[", "model")}
qplot(rsquare, data=coef, geom="histogram", binwidth=0.01)

# A scatterplot of model intercept and slope, with one point for each
# model (player).  The size of the points is proportion to the R-square
# of the model. Vertical and horizontal lines emphasis the x and y
# origins.
ggplot(coef, aes(slope, intercept)) + 
  geom_point(aes(size = rsquare)) +
  geom_vline(size=0.5, colour="grey50") + 
  geom_hline(size = 0.5, colour="grey50") + 
  scale_area()
last_plot() + xlim(-0.01, 0.01) + ylim(-0.1, 0.25)

# Star glyphs showing variation in ozone over time at each spatial
# location.
ozstars <- make_stars(ozm, "time", "value")
res <- 1.2
ggplot(ozstars, aes(x = long + res * x, y = lat + res * y)) + map +
 geom_path(aes(group = interaction(long, lat)), fill=NA, colour="grey50")

value <- ozone[1, 1, ]
time <- 1:72 / 12
month.abbr <- c("Jan", "Feb", "Mar", "Apr", "May", 
 "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
month <- factor(rep(month.abbr, length = 72), levels = month.abbr)
year <- rep(1:6, each = 12)

# Two ways of displaying the seasonal changes.  (Left) A single time
# series over all six years and (right) a line for each year.
qplot(time, value, geom="line") 
qplot(month, value, geom="line", group = year)

library(MASS)

deseas1 <- rlm(value ~ month - 1)
summary(deseas1)
coef(deseas1)

# Deasonalised ozone trends.  (Left) deasonalised trend over six years.
# (Right) Estimates of seasonal effects.  Compare to
# Figure~\ref{fig:ozone-ts}
qplot(time, resid(deseas1), geom="line") + geom_hline(colour="grey70")
qplot(month, unname(coef(deseas1)), geom="line", group = 1) + 
  geom_hline(colour="grey70")

deseasf <- function(value) rlm(value ~ month - 1)
models <- alply(ozone, 1:2, deseasf)

coefs <- laply(models, coef)
dimnames(coefs)[[3]] <- month.abbr
names(dimnames(coefs))[3] <- "month"

deseas <- laply(models, resid)
dimnames(deseas)[[3]] <- 1:72
names(dimnames(deseas))[3] <- "time"

dim(coefs)
dim(deseas)

coefs_df <- melt(coefs)
coefs_df <- ddply(coefs_df, .(lat, long), transform, 
 avg = mean(value),
 std = value / max(value)
)
levels(coefs_df$month) <- month.abbr
head(coefs_df)

deseas_df <- melt(deseas)
head(deseas_df)
 

# Star glyphs showing seasonal variation.  Estimates of seasonal
# effects are standardised to have the same maximum at each location to
# make it easier to compare the general pattern.  The glyph colours
# give the overall average ozone measurement.  Note the strong spatial
# correlation: nearby glyphs have similar shapes.
coef_stars <- make_stars(coefs_df, "month", "std")
res <- 1.2
ggplot(coef_stars, aes(x = long + res * x, y = lat + res * y, fill=avg)) +
 map + geom_polygon(aes(group = interaction(long, lat)), colour="grey50") +
 scale_fill_gradient(low=brightblue, high="yellow") + 
 opts(aspect.ratio = 1)

# Star glyphs showing deasonalised trends.  This plot contains a lot of
# data---over 40,000 observations---and rewards detailed study.
# Looking at a printed version also helps as the resolution of a
# printer (600 dpi) is much higher than that of the screen (~100 dpi).
deseas_stars <- make_stars(deseas_df, "time", "value")
res <- 1.2
ggplot(deseas_stars, aes(x = long + res * x, y = lat + res * y)) +
 map + geom_path(aes(group = interaction(long, lat)), 
                 colour="grey50", fill=NA) +
 opts(aspect.ratio = 1)

coef_limits <- range(coefs_df$value)
coef_mid <- mean(coefs_df$value)
monthsurface <- function(mon) {
  df <- subset(coefs_df, month == mon)
  qplot(long, lat, data = df, fill = value, geom="tile") + 
  scale_fill_gradient(limits = coef_limits, 
    low=brightblue, high="yellow") + map + opts(aspect.ratio = 1)
}

# Tile plots of coefficients for January (left) and July (right).
monthsurface("Jan")
monthsurface("Jul")
