context("Mutate")

test_that("mutate behaves the same as transform", {
  m1 <- mutate(airquality, Ozone = -Ozone)
  t1 <- mutate(airquality, Ozone = -Ozone)
  expect_that(m1, equals(t1))
  
  m2 <- mutate(airquality, new = -Ozone, Temp = (Temp-32)/1.8)
  t2 <- mutate(airquality, new = -Ozone, Temp = (Temp-32)/1.8)
  expect_that(m2, equals(t2))
})

test_that("columns can depend on previously created", {
  m1 <- mutate(airquality, dm = Month + Day / 31, dm2 = 2 * dm)
  dm2 <- with(airquality, 2 * (Month + Day / 31))
  
  expect_that(m1$dm2, equals(dm2))
})