# Apply 
# 
#   * function calling style: f(x[1,]) vs f(x[1,1], x[1,2], x[1,3]) .explode
#   * robustness: .try, .quiet
# 
#X f <- robustify(sqrt)
#X stopifnot(identical(f, sqrt))
#X f <- robustify(sqrt, .try = TRUE)
#X f(5)
#X f("a")
#X f <- robustify(sqrt, .try = TRUE, .quiet = TRUE)
#X f("a")
robustify <- function(f, .try = FALSE, .quiet = FALSE, .explode = FALSE) {
  fun <- if (.explode) function(...) do.call(f, ...) else f
  if (.try) failwith(NULL, fun, quiet = .quiet) else fun
}