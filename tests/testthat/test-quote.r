context("Quoting")

test_that("quoting captures current environment", {
  x <- .(a, b, c)
  expect_that(attr(x, "env"), is_identical_to(environment()))

  x <- as.quoted(c("a", "b", "c"))
  expect_that(attr(x, "env"), is_identical_to(environment()))
})

test_that("can't pass bogus environment for evaluation", {
  expect_that(eval.quoted(.(x), envir = -1), throws_error("must be"))
})

test_that("evaluation takes place in correct environment", {
  a <- 2
  x <- local({
    a <- 1
    .(a)
  })

  expect_that(eval.quoted(x)$a, equals(1))

  df <- data.frame(x = 1:10)
  x <- local({
    a <- 1
    .(x * a)
  })
  expect_that(eval.quoted(x, df)[[1]], equals(1:10))

})

test_that("failsafe evaluation", {
  b <- 2
  x <- local({
    a <- 1
    .(a)
  })

  expect_that(eval.quoted(x, try = TRUE)$b, equals(NULL))
})

test_that("names work for long expressions", {
 # nolint start
 q <- .(foo = barjasdfgjadhfgjsdhfgusdhfgusheguisdhguioahsrofasdgsdfgsdfg +
              dfgafgasdfgsdfgsdfgsdfgsdfgsdfgsdfg)
 # nolint end
 expect_that(names(q), equals("foo"))
})

test_that("printing works", {
  expect_that(print(as.quoted(NULL)), testthat::prints_text("list()"))
  expect_that(print(as.quoted("id")), testthat::prints_text("id"))
  expect_that(print(as.quoted("3")), testthat::prints_text("3"))
  expect_that(print(as.quoted(c("a", "b"))), testthat::prints_text("List of 2"))
  expect_that(print(as.quoted(~a+b)), testthat::prints_text("List of 2"))
  expect_that(print(as.quoted(~a)), testthat::prints_text("List of 1"))
  expect_that(print(as.quoted(as.name("a"))), testthat::prints_text("List of 1"))
})

test_that("concatenation", {
  expect_equal(c(.(a), .(b)), .(a, b))
  expect_equal(c(.(a), .(b, c)), .(a, b, c))
  expect_equal(c(.(a), .(b), .(c)), .(a, b, c))
})

test_that("extraction", {
  expect_equal(.(a, b)[1], .(a))
  expect_equal(.(a, b, c)[-1], .(b, c))
})
