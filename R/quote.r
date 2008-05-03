"." <- function(...) {
  structure(as.list(match.call()[-1]), class="quoted")
}

print.quoted <- function(x, ...) str(x)
str.quoted <- function(object, ...) str(unclass(object), ...)

names.quoted <- function(x) {
  part_names <- make.names(x)
  user_names <- names(unclass(x))

  if (!is.null(user_names)) {
    part_names[user_names != ""] <- user_names[user_names != ""]
  }
  
  part_names
}

eval.quoted <- function(exprs,  envir = parent.frame(), enclos = if (is.list(envir) || is.pairlist(envir)) parent.frame() else baseenv()) {

  results <- lapply(exprs, function(x.) eval(x., envir, enclos))
  names(results) <- names(exprs)
  
  results
}

is.formula <- function(x) inherits(x, "formula")


as.quoted <- function(x) UseMethod("as.quoted")
as.quoted.call <- function(x) structure(as.list(x)[-1], class="quoted")
as.quoted.character <- function(x) {
  stopifnot(length(x) == 1)
  lapply(strsplit(x, "~")[[1]], function(x) parse(text = x)[[1]])
}
as.quoted.formula <- function(x) as.quoted(deparse(x))


all.equal.quoted <- function(target, current, ...) {
  
}