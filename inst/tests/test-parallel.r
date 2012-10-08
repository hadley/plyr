context("Parallel")
require("doMC")

registerDoMC(2)

test_that("l_ply respects .parallel", {
  expect_that(
    l_ply(c(0.1, 0.1), Sys.sleep, .parallel = TRUE),
    takes_less_than(0.15))
})

test_that("l_ply + .parallel complains about invalid arguments", {
  expect_message(
    l_ply(1:10, force, .parallel = TRUE, .print = TRUE),
    "Printing disabled")
  expect_message(
    l_ply(1:10, force, .parallel = TRUE, .progress = "text"),
    "Progress disabled")
})
