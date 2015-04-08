context("Manipulation")

test_that("each() function", {

  expect_equal(each(min, max)(1:10), c(min=1, max=10))
  expect_equal(each(c(min, max))(1:10), c(min=1, max=10))
  expect_equal(each(top=max, bottom=min)(1:10), c(top=10, bottom=1))
  expect_equal(each(top=max, min)(1:10), c(top=10, min=1))
  expect_equal(each(top="max", "min")(1:10), c(top=10, min=1))
  expect_equal(each(c("min", max))(1:10), c(min=1, max=10))

  # Odd behavior, kept for compatibility:
  expect_equal(each(pmin)(1:10, 10:1), c(1:5, 5:1))
  expect_equal(each(max, pmin)(1:10, 10:1), c(max=10, pmin=c(1:5, 5:1)))
  expect_error(each()(1:10))

})

test_that("here() function", {

  df <- data.frame(a = rep(c("a","b"), each = 10), b = 1:20)
  f1 <- function(label) {
     ddply(df, "a", mutate, label = paste(label, b))
  }
  expect_error(f1("name:"))

  f2 <- function(label) {
     ddply(df, "a", here(mutate), label = paste(label, b))
  }
  expect_true(all(grepl("^name: ", f2("name:")$label)))

  f3 <- function() {
    label <- "name:"
    ddply(df, "a", here(mutate), label = paste(label, b))
  }
  expect_true(all(grepl("^name: ", f3()$label)))

})

test_that("defaults() function", {

  expect_equal(defaults(c(a=1, b=2), c(c=3)), c(a=1, b=2, c=3))
  expect_equal(defaults(c(a=1, b=2), c(a=3, b=4)), c(a=1, b=2))
  expect_equal(defaults(c(a=1, b=2), c(a=3, d=4)), c(a=1, b=2, d=4))
  expect_equal(defaults(c(a=1, b=2), c()), c(a=1, b=2))
  expect_equal(defaults(c(), c(a=3, d=4)), c(a=3, d=4))

})

test_that("as.data.frame.function() function", {

  expect_equal(as.data.frame(identity)(1:10), data.frame(value = 1:10))
  expect_equal(as.data.frame(rev)(1:10), data.frame(value = 10:1))

  # Always create value column, even if empty
  expect_equal(as.data.frame(identity)(numeric()), data.frame(value = numeric()))

})

test_that("name_rows() function", {

  expect_equal(name_rows(baseball)$.rownames, rownames(baseball))
  expect_equal(rownames(name_rows(name_rows(baseball))), rownames(baseball))

})

test_that("round_any() function", {

  expect_equal(round_any(135, 10), 140)
  expect_equal(round_any(135, 100), 100)
  expect_equal(round_any(135, 25), 125)
  expect_equal(round_any(135, 10, floor), 130)
  expect_equal(round_any(135, 100, floor), 100)
  expect_equal(round_any(135, 25, floor), 125)
  expect_equal(round_any(135, 10, ceiling), 140)
  expect_equal(round_any(135, 100, ceiling), 200)
  expect_equal(round_any(135, 25, ceiling), 150)

  expect_equal(round_any(as.POSIXct("2000-01-01 11:00:00", tz="UTC"), 86400),
               as.POSIXct("2000-01-01", tz="UTC"))
  expect_equal(round_any(as.POSIXct("2000-01-01 11:11:11", tz="UTC"), 3600),
               as.POSIXct("2000-01-01 11:00", tz="UTC"))
  expect_equal(round_any(as.POSIXct("2000-01-01 11:11:11", tz="UTC"), 10, ceiling),
               as.POSIXct("2000-01-01 11:11:20", tz="UTC"))

})

test_that("take() function", {

  x <- array(seq_len(3 * 4 * 5), c(3, 4, 5))
  expect_equal(take(x, 3, 1), x[,,1, drop = FALSE])
  expect_equal(take(x, 2, 1), x[,1,, drop = FALSE])
  expect_equal(take(x, 1, 1), x[1,,, drop = FALSE])
  expect_equal(take(x, 3, 1, drop = TRUE), x[,,1])
  expect_equal(take(x, 2, 1, drop = TRUE), x[,1,])
  expect_equal(take(x, 1, 1, drop = TRUE), x[1,,])

  expect_equal(take(x, 1:3, 3:5), x[3,4,5, drop = FALSE])
  expect_equal(take(x, 1:2, 2:3), x[2,3,, drop = FALSE])
  expect_equal(take(x, 2:3, 1:2), x[,1,2, drop = FALSE])

  # Odd behavior, tested for compatibility:
  expect_equal(take(x, 1:3, 1), x[1,1,1, drop = FALSE])
  expect_equal(take(x, 1:2, 1), x[1,1,, drop = FALSE])
  expect_equal(take(x, 2:3, 1), x[,1,1, drop = FALSE])

})
