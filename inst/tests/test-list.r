context("Lists")

test_that("data frame variables converted to list names", {
  x <- dlply(esoph, .(alcgp), function(df) mean(df$ncases))
  expect_that(names(x), equals(levels(esoph$alcgp)))

  x <- dlply(esoph, .(alcgp, agegp), function(df) mean(df$ncases))
  y <- ddply(esoph, .(alcgp, agegp), function(df) mean(df$ncases))
  labs <- paste(y$alcgp, y$agegp, sep = ".")
  expect_that(names(x), equals(labs))
  
})

test_that("list names are preserved", {
  a <- 1:10
  expect_that(names(llply(a)), equals(NULL))

  names(a) <- letters[1:10]
  expect_that(names(llply(a)), equals(letters[1:10]))
  
})

test_that("ldply handles NA column names when returned by .fun", {
 res <- ddply(data.frame(health = "very good", age=3), .(age), function(x) table(x$health,useNA = "always"))
 expected_res <- structure(list(age = 3, `very good` = 1L, `NA` = 0L), .Names = c("age", "very good", NA), row.names = c(NA, -1L), class = "data.frame")

 expect_that(res, is_identical_to(expected_res))
})