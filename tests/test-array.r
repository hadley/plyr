context("Arrays")

test_that("incorrect result dimensions raise errors", {
  fs <- list(
    function(x) rep(x, sample(10, 1)),
    function(x) if (x < 5) x else matrix(x, 2, 2)
  )
  
  expect_that(laply(1:10, fs[[1]]), throws_error("same dim"))
  expect_that(laply(1:10, fs[[2]]), throws_error("same number"))
})


test_that("simple operations equivalent to vectorised form", {
  expect_that(laply(1:10, mean), is_equivalent_to(1:10))
  expect_that(laply(1:10, sqrt), is_equivalent_to(sqrt(1:10)))
})

test_that("array binding is correct", {
  library(abind)
  f <- function(x) matrix(x, 2, 2)
  m2d <- lapply(1:10, f)
  m3d <- abind(m2d, along = 0)
  
  expect_that(laply(1:10, f), is_equivalent_to(m3d))

  f <- function(x) array(x, c(2, 2, 2))
  m3d <- lapply(1:10, f)
  m4d <- abind(m3d, along = 0)
  
  expect_that(laply(1:10, f), is_equivalent_to(m4d))
})

test_that("idempotent function equivalent to permutation",  {  
  a <- array(1:60, c(3,4,5))
  
  aaperm <- function(i) aaply(a, i, force)
  
  expect_that(aaperm(1), is_equivalent_to(a))
  expect_that(aaperm(1:2), is_equivalent_to(a))
  expect_that(aaperm(1:3), is_equivalent_to(a))
  
  expect_that(aaperm(2), is_equivalent_to(aperm(a, c(2,1,3))))
  expect_that(aaperm(3), is_equivalent_to(aperm(a, c(3,1,2))))

  expect_that(aaperm(c(2, 3)), is_equivalent_to(aperm(a, c(2, 3, 1))))
  expect_that(aaperm(c(1, 3)), is_equivalent_to(aperm(a, c(1, 3, 2))))
})