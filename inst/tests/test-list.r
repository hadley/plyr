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

# Test for #142
test_that(".n column can be renamed", {
  f <- function() data.frame(r=runif(1))
  
  out1 <- rdply(4, f)
  out2 <- rdply(4, f, .id='x')
  
  expect_equal(names(out1), c('.n', 'r'))
  expect_equal(names(out2), c('x', 'r'))
})
