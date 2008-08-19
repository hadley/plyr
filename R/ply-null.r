# To nothing -----------------------------------------------------------------
#  - purely for side effects (graphics, io, etc)
#  - remember to print lattice and ggplot2 graphics

l_ply <- function(data., fun. = NULL, ..., progress. = "none", print. = FALSE) {
  if (is.character(fun.)) fun. <- match.fun(fun.)
  
  if (is.character(progress.)) 
    progress <- create_progress_bar(progress.)
  progress$init(length(data.))
  
  data. <- as.list(data.)
  for(i in seq_along(data.)) {
    x <- fun.(data.[[i]], ...)
    if (print.) print(x)
    progress$step()
  }
  
  progress$term()
  invisible()
}

d_ply <- function(data., variables., fun. = NULL, ..., progress. = "none", print. = FALSE) {
  data. <- as.data.frame(data.)
  pieces <- splitter_d(data., variables.)
  
  l_ply(pieces, fun., progress. = progress., print. = print.)
}

a_ply <- function(data., margins., fun. = NULL, ..., progress. = "none", print. = FALSE) {
  pieces <- splitter_a(data., margins.)
  
  l_ply(pieces, fun., progress. = progress., print. = print.)
}