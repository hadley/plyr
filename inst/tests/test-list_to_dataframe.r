context("List to data frame")

a <- as.POSIXct(1, origin="2011-01-01")

test_that("classes preserved for atomic scalars", {
  l <- list(a, a+1)
  df <- list_to_dataframe(l)
  expect_that(class(df), equals("data.frame"))
  expect_that(class(df[,1]), equals(class(a)))
})

test_that("classes preserved for atomic scalars in list of length 1", {
  l <- list(a)
  df <- list_to_dataframe(l)
  expect_that(class(df), equals("data.frame"))
  expect_that(class(df[,1]), equals(class(a)))
})

test_that("classes preserved for atomic vectors", {
  l <- list(c(a, a+1), c(a+2, a+3))
  df <- list_to_dataframe(l)
  expect_that(class(df), equals("data.frame"))
  expect_that(class(df[,1]), equals(class(a)))
})

test_that("classes preserved for atomic vectors in list of length 1", {
  l <- list(c(a, a+1))
  df <- list_to_dataframe(l)
  expect_that(class(df), equals("data.frame"))
  expect_that(class(df[,1]), equals(class(a)))
})

test_that("classes preserved for data.frames", {
  l <- list(data.frame(V1=a, V2=a+1), data.frame(V1=a+2, V2=a+3))
  df <- list_to_dataframe(l)
  expect_that(class(df), equals("data.frame"))
  expect_that(class(df[,1]), equals(class(a)))
})

test_that("named preserved for atomic scalars", {
  l <- list(c(foo=1), c(foo=2))
  df <- list_to_dataframe(l)
  expect_that(class(df), equals("data.frame"))
  expect_that(names(df), equals(c("foo")))
})

test_that("named preserved for atomic scalars in list of length 1", {
  l <- list(c(foo=1))
  df <- list_to_dataframe(l)
  expect_that(class(df), equals("data.frame"))
  expect_that(names(df), equals(c("foo")))
})

test_that("named preserved for atomic vectors", {
  l <- list(c(foo=1, bar=2), c(foo=3, bar=4))
  df <- list_to_dataframe(l)
  expect_that(class(df), equals("data.frame"))
  expect_that(names(df), equals(c("foo","bar")))
})

test_that("named preserved for atomic vectors n list of length 1", {
  l <- list(c(foo=1, bar=2))
  df <- list_to_dataframe(l)
  expect_that(class(df), equals("data.frame"))
  expect_that(names(df), equals(c("foo","bar")))
})

test_that("named preserved for data.frames", {
  l <- list(data.frame(foo=1, bar=2), data.frame(foo=3, bar=4))
  df <- list_to_dataframe(l)
  expect_that(class(df), equals("data.frame"))
  expect_that(names(df), equals(c("foo","bar")))
})

test_that("named preserved and filled for atomic vectors", {
  l <- list(c(foo=1, 2), c(foo=3, 4))
  df <- list_to_dataframe(l)
  expect_that(class(df), equals("data.frame"))
  expect_that(names(df), equals(c("foo","V2")))
})
