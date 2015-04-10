context("Mutate")

test_that("mutate behaves the same as transform", {
  m1 <- mutate(airquality, Ozone = -Ozone)
  t1 <- transform(airquality, Ozone = -Ozone)
  expect_that(m1, equals(t1))

  m2 <- mutate(airquality, new = -Ozone, Temp = (Temp - 32) / 1.8)
  t2 <- transform(airquality, new = -Ozone, Temp = (Temp - 32) / 1.8)
  expect_that(m2, equals(t2))
})

test_that("columns can depend on previously created", {
  m1 <- mutate(airquality, dm = Month + Day / 31, dm2 = 2 * dm)
  dm2 <- with(airquality, 2 * (Month + Day / 31))

  expect_that(m1$dm2, equals(dm2))
})

test_that("mutating a column twice does not work", {
  # For compatibility, see #218
  m1 <- mutate(airquality, dm = 0, dm = Month + Day / 31)
  expect_equal(m1$dm, rep(0, length(m1$dm)))
})
