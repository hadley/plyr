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