library(ggplot2)
library(stringr)

timings <- read.csv("timings.csv")
timings$time <- as.POSIXct(timings$time)
timings$sha <- reorder(timings$sha, as.numeric(timings$time))
timings <- ddply(timings, c("file"), transform, vers = id_var(as.numeric(sha)))

ply <- subset(timings, str_detect(file, "ply"))

ggplot(ply, aes(sha, elapsed, group = name)) + 
  geom_point() + 
  geom_line(stat = "summary", fun.y = median) + 
  geom_text(aes(x = 0.9, label = name), subset = .(vers == 1), 
    hjust = 1, size = 4) +
  facet_grid(. ~ file, scale = "free", space = "free") +
  expand_limits(y = 0)
