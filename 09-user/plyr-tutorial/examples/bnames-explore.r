library(plyr)

bnames <- read.csv("bnames.csv", stringsAsFactors = FALSE)
head(bnames)

# Whole dataset transformations ---------------------------------------------
letter <- function(x, n = 1) {
  if (n < 0) {
    nc <- nchar(x)
    n <- nc + n + 1
  }
  tolower(substr(x, n, n))
}
vowels <- function(x) {
  nchar(gsub("[^aeiou]", "", x))
}

bnames <- transform(bnames,
  first = letter(name, 1),
  last = letter(name, -1),
  length = nchar(name),
  vowels = vowels(name)
)

# Whole dataset summaries ----------------------------------------------------

summarise(bnames, 
  max_perc = max(percent),
  min_perc = min(percent))


# Group-wise transformations  ------------------------------------------------

# Want to calculate rank of each name in each year (per sex).  This is easy if
# we have a single sex for a single year:
one <- subset(bnames, sex == "boy" & year == 2008)
one$rank <- rank(-one$percent, ties.method = "first")
# or
one <- transform(one, rank = rank(-percent, ties.method = "first"))
head(one)

# Conceptually if we want to perform this same task for every sex in every 
# year, we need to split up the data, apply the transformation to every piece
# and then join the pieces back together

# This is what ddply does
bnames <- ddply(bnames, c("sex", "year"), transform, 
  rank = rank(-percent, ties.method = "first"))

# ddply basically works as follows:
pieces <- split(bnames, list(bnames$sex, bnames$year))
results <- vector("list", length(pieces))
for(i in seq_along(pieces)) {
  piece <- pieces[[i]]
  piece <- transform(piece, rank = rank(-percent, ties.method = "first"))
  results[[i]] <- piece
}
result <- do.call("rbind", results)


# Group-wise summaries -------------------------------------------------------

# Group-wise summaries are much more interesting!

ddply(bnames, c("name"), summarise, tot = sum(percent))
ddply(bnames, c("length"), summarise, tot = sum(percent))
ddply(bnames, c("year", "sex"), summarise, tot = sum(percent))

fl <- ddply(bnames, c("year", "sex", "first"), summarise, tot = sum(percent))
library(ggplot2)
qplot(year, tot, data = fl, geom = "line", colour = sex, facets = ~ first)


# Some R functions implement special cases of group-wise summaries.  For 
# example, when you are summing a single variable, you can use xtabs:
as.data.frame(xtabs(percent ~ name, data = bnames))
# These methods tend to be much faster, but they are harder to remember