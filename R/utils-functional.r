# f <- function(...) {
#   dots()
# }

# g <- function() {
#   f <- function(x, y, ...) {
#     dots()
#   }
#   f(x = 1, y = 2, z = 3)
# }
dots <- function() {
  call <- sys.call(-1)
  def <- eval(call[[1]], parent.frame(2))
  match.call(def, call, expand.dots = FALSE)$`...`
}


