library(maps)
outlines <- as.data.frame(map("world",xlim=-c(113.8, 56.2), ylim=c(-21.2, 36.2), plot=FALSE)[c("x","y")])
map <- c(
  geom_path(aes(x=x, y=y, fill=NULL, group=NULL, order=NULL, size=NULL), data = outlines, colour = alpha("grey20", 0.2)),
  scale_x_continuous("", limits = c(-114.8, -55.2), breaks=c(-110, -85, -60)),
  scale_y_continuous("", limits = c(-22.2, 37.2))
)

# scale_x_continuous("", limits = c(-113.8, -56.2)),
# scale_y_continuous("", limits = c(-21.2, 36.2))



ozm <- melt(ozone)
fac <- laply(ozm, is.factor)
ozm[fac] <- llply(ozm[fac], function(x) as.numeric(as.character(x)))

small_mult <- function(df) {
  res <- 2 # lat and long measured every 2.5, but need a gap

  rexpo <- transform(df, 
    rozone = rescaler(value, type="range") - 0.5,
    rtime = rescaler(time %% 12, type="range") - 0.5,
    year = time %/% 12
  )

  ggplot(rexpo, aes(x = long + res * rtime, y = lat + res * rozone)) + map  
}

make_stars <- function(data, time, value) {
  data[, c(time, value)] <- lapply(data[, c(time, value)], function(x) {
    x <- as.numeric(x)
    (x - min(x)) / diff(range(x))
  })
  
  ddply(data, .(lat, long), function(df) {
    df$x <- df[, value] * cos(df[, time] * 2 * pi + pi / 2)
    df$y <- df[, value] * sin(df[, time] * 2 * pi + pi / 2)
    df[order(df[, time]), ]
  })
}
# df <- stars(owide[, 1:2], owide[, -(1:2)])
