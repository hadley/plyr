context("Parallel")

if (require("doMC", quietly = TRUE)) {
  registerDoMC(2)

  if (identical(Sys.getenv("NOT_CRAN"), "true")) {
    test_that("l_ply respects .parallel", {
      expect_that(
        l_ply(c(0.1, 0.1), Sys.sleep, .parallel = TRUE),
        takes_less_than(0.15))
    })
  }

  test_that("l_ply + .parallel complains about invalid arguments", {
    expect_message(
      l_ply(1:10, force, .parallel = TRUE, .print = TRUE),
      "Printing disabled")
    expect_message(
      l_ply(1:10, force, .parallel = TRUE, .progress = "text"),
      "Progress disabled")
  })

  test_that(".paropts passes options to foreach", {
    combine <- function(a, b) NULL
    x <- llply(1:10, identity, .parallel = TRUE,
      .paropts = list(.combine = combine))
    expect_equal(x, NULL)
  })

  registerDoMC(1)
}
