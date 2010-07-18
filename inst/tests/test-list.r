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