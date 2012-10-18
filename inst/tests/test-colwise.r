context("Colwise")


test_that("data.frames with replicated names are treated correctly", {
  d <- data.frame(x = c(1, 3), x = c(1, 3), check.names = FALSE)

  expect_that(length(colwise(mean)(d)), equals(2))
  expect_that(names(colwise(mean)(d)), equals(make.unique(names(d))))

})
