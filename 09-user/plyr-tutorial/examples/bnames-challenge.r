library(plyr)

bnames <- read.csv("bnames.csv", stringsAsFactors = FALSE)
bnames <- ddply(bnames, c("sex", "year"), transform, 
  rank = rank(-percent, ties.method = "first"))

top100 <- subset(bnames, rank <= 100)

top100s <- ddply(top100, c("sex", "year"), summarise,
  tot = sum(percent))
  
library(ggplot2)
qplot(year, tot, data = top100s, colour = sex, geom = "line", ylim = c(0, 1))
ggsave("bname-top100.pdf", width = 8, height = 6)