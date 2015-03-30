context("Quoting")

test_that("quoting captures current environment", {
  x <- .(a, b, c)
  expect_that(attr(x, "env"), is_identical_to(environment()))

  x <- as.quoted(c("a", "b", "c"))
  expect_that(attr(x, "env"), is_identical_to(environment()))
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

test_that("names work for long expressions", {
 q <- .(foo = barjasdfgjadhfgjsdhfgusdhfgusheguisdhguioahsrofasdgsdfgsdfg +
              dfgafgasdfgsdfgsdfgsdfgsdfgsdfgsdfg)
 expect_that(names(q), equals("foo"))
})
