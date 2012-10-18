context("Empty inputs")

test_that("empty arrays returns object of same shape", {
  x <- structure(integer(0), .Dim = c(0L, 0L, 0L))

  expect_that(aaply(x, 1, identity), equals(logical()))
  expect_that(aaply(x, 2, identity), equals(logical()))
  expect_that(aaply(x, 3, identity), equals(logical()))

  expect_that(adply(x, 1, identity), equals(data.frame()))
  expect_that(alply(x, 1, identity), is_equivalent_to(list()))
})

test_that("empty lists return an empty object", {
  expect_that(llply(list(), identity), equals(list()))
  expect_that(laply(list(), identity), equals(logical()))
  expect_that(ldply(list(), identity), equals(data.frame()))
})

test_that("empty data frames returns empty object", {
  df <- data.frame(x = numeric(0), a = numeric(0))
  expect_that(ddply(df, "a", identity), equals(df))
  expect_that(dlply(df, "a", identity), equals(list()))
  expect_that(daply(df, "a", identity), equals(logical()))
})

test_that("empty data frame results returns empty object", {
  df <- data.frame(a = 1:10)
  expect_that(
    ddply(df, "a", function(x) NULL),
    equals(data.frame()))
  expect_that(
    dlply(df, "a", function(x) NULL),
    equals(rep(list(NULL), 10), check.attributes = FALSE))
  expect_that(
    daply(df, "a", function(x) NULL),
    throws_error("must have one or more dimensions"))

})
