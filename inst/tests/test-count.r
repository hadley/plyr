library(testthat)
context("Count")

count_f <- function(...) count(...)$freq
table_f <- function(...) { 
  x <- unname(as.numeric(table(rev(...))))
  x[x != 0]
}

test_that("count matches table", {
  data <- list(
    mtcars["cyl"],
    mtcars["mpg"],
    mtcars[c("cyl", "vs")])
  
  for(datum in data) {
    expect_that(count_f(datum), equals(table_f(datum)))
  }  

})

test_that("random order doesn't affect count", {
  usual <- count(mtcars, "cyl")
  
  for(i in 1:5) {
    mtcars_r <- mtcars[sample(1:nrow(mtcars)), ]
    expect_that(count(mtcars_r, "cyl"), equals(usual))
  }
  
})

test_that("weighted count matches xtab", {
  xt1 <- as.data.frame(xtabs(g ~ id, data = baseball), responseName = "freq")
  xt1$id <- as.character(xt1$id)
  ct1 <- count(baseball, "id", "g")
  
  expect_that(ct1, equals(xt1))
  
  xt2 <- as.data.frame(xtabs(g ~ year + team, data = baseball), 
    responseName = "freq")
  xt2 <- subset(xt2, freq > 0)
  xt2$year <- as.numeric(as.character(xt2$year))
  xt2$team <- as.character(xt2$team)
  xt2 <- arrange(xt2, year, team)
  ct2 <- count(baseball, c("year", "team"), "g")
  
  expect_that(ct2, equals(xt2))
  
})