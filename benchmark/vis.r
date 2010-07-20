library(ggplot2)
library(stringr)

timings <- read.csv("timings.csv")
timings$time <- as.POSIXct(timings$time)
timings$sha <- reorder(timings$sha, as.numeric(timings$time))
timings <- ddply(timings, c("file"), transform, vers = id_var(sha))

ply <- subset(timings, str_detect(file, "ply"))

ggplot(ply, aes(sha, elapsed, group = name)) + 
  geom_point() + 
  geom_line() + 
  facet_grid(. ~ file, scale = "free", space = "free")
