# Quote variables
# Create a list of unevaluated expressions for later evaluation
# 
# This function is similar to \code{\link{~}} in that it is used to
# capture the name of variables, not their current value.  This is used
# throughout plyr to specify the names of variables (or more complicated
# expressions).
# 
# Similar tricks can be performed with \code{\link{substitute}}, but when
# functions can be called in multiple ways it becomes increasingly tricky
# to ensure that the values are extracted from the correct frame.  Substitute
# tricks also make it difficult to program against the functions that use
# them, while the \code{quoted} class provides 
# \code{\link{as.quoted.character}} to convert strings to the appropriate
# data structure.
# 
# @arguments unevaluated expressions to be recorded.  Specify names if you want the set the names of the resultant variables
# @value list of symbol and language primitives
# @alias quoted
#X .(a, b, c)
#X .(first = a, second = b, third = c)
#X .(a ^ 2, b - d, log(c))
#X as.quoted(~ a + b + c)
#X as.quoted(a ~ b + c)
#X as.quoted(c("a", "b", "c"))
#X 
#X # Some examples using ddply - look at the column names
#X ddply(mtcars, "cyl", each(nrow, ncol))
#X ddply(mtcars, ~ cyl, each(nrow, ncol))
#X ddply(mtcars, .(cyl), each(nrow, ncol))
#X ddply(mtcars, .(log(cyl)), each(nrow, ncol))
#X ddply(mtcars, .(logcyl = log(cyl)), each(nrow, ncol))
#X ddply(mtcars, .(vs + am), each(nrow, ncol))
#X ddply(mtcars, .(vsam = vs + am), each(nrow, ncol))
. <- function(...) {
  structure(as.list(match.call()[-1]), class="quoted")
}

# Print quoted variables
# Display the \code{\link{str}}ucture of quoted variables
# 
# @keyword internal
print.quoted <- function(x, ...) str(x)

# Compute names of quoted variables
# Figure out names of quoted variables, using specified names if they exist, otherwise using \code{\link{make.names}} on the values.
# 
# @keyword internal
names.quoted <- function(x) {
  part_names <- make.names(x)
  user_names <- names(unclass(x))

  if (!is.null(user_names)) {
    part_names[user_names != ""] <- user_names[user_names != ""]
  }
  
  part_names
}

# Evaluate a quoted list of variables 
# Evaluates quoted variables in specified environment
# 
# @value a list
# @keyword internal
eval.quoted <- function(exprs,  envir = parent.frame(), enclos = if (is.list(envir) || is.pairlist(envir)) parent.frame() else baseenv()) {

  results <- lapply(exprs, function(x.) eval(x., envir, enclos))
  names(results) <- names(exprs)
  
  results
}

# Convert input to quoted variables
# Convert characters, formulas and calls to quoted variables.
# 
# This method is called by default on all plyr functions that take a 
# \code{variables.} argument, so that equivalent forms can be used anywhere.
# 
# Currently conversions exist for character vectors, formulas and 
# call objects.
# 
# @value a list of quoted variables
# @seealso \code{\link{.}}
# @alias as.quoted.call
# @alias as.quoted.character
# @alias as.quoted.formula
# @alias as.quoted.quoted
#X as.quoted(c("a", "b", "log(d)"))
#X as.quoted(a ~ b + log(d))
as.quoted <- function(x) UseMethod("as.quoted")
as.quoted.call <- function(x) structure(as.list(x)[-1], class="quoted")
as.quoted.character <- function(x) {
  structure(
    lapply(x, function(x) parse(text = x)[[1]]), 
    class="quoted"
  )
}
as.quoted.formula <- function(x) {
  simplify <- function(x) {
    if (length(x) == 2 && x[[1]] == as.name("~")) {
      return(x[[2]])
    }
    if (length(x) < 3) return(list(x))
    op <- x[[1]]; a <- x[[2]]; b <- x[[3]]

    if (op == as.name("+") || op == as.name("*") || op == as.name("~")) {
      c(simplify(a), simplify(b))
    } else if (op == as.name("-")) {
      c(simplify(a), bquote(-.(x), list(x=simplify(b))))
    } else {
      x
    }
  }

  simplify(x)
}
as.quoted.quoted <- function(x) x

# Is a formula?
# Checks if argument is a formula
# 
# @keyword internal
is.formula <- function(x) inherits(x, "formula")
