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

