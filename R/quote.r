u <- function(...) {
  structure(as.list(match.call()[-1]), class="uneval")
}

print.uneval <- function(x, ...) str(x)
str.uneval <- function(object, ...) str(unclass(object), ...)

names.uneval <- function(x) {
  part_names <- make.names(x)
  user_names <- names(unclass(x))

  if (!is.null(user_names)) {
    part_names[user_names != ""] <- user_names[user_names != ""]
  }
  
  part_names
}

evalu <- function(exprs,  envir = parent.frame(), enclos = if (is.list(envir) || is.pairlist(envir)) parent.frame() else baseenv()) {

  results <- lapply(exprs, function(x.) eval(x., envir, enclos))
  names(results) <- names(exprs)
  
  results
}

