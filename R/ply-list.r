# To lists -------------------------------------------------------------------

llply <- function(data., fun. = NULL, ..., progress. = "none") {
  if (!is(data., "split")) data. <- as.list(data.)
  if (is.null(fun.)) return(data.)
  if (length(data.) == 0) return(list())
  
  if (is.character(fun.)) fun. <- match.fun(fun.)
  
  progress <- create_progress_bar(progress.)
  
  progress$init(length(data.))

  f2 <- function(...) {
    res <- fun.(...)
    progress$step()
    res
  }
  
  result <- lapply(data., f2, ...)
  mostattributes(result) <- attributes(data.)
  progress$term()
  
  result
}

#X linmod <- function(df) lm(rbi ~ year, data = transform(df, year = year - min(year)))
#X models <- dlply(baseball, .(id), linmod)
#X models[[1]]
#X
#X coef <- ldply(models, coef)
#X with(coef, plot(`(Intercept)`, year))
#X qual <- ldply(models, function(mod) summary(mod)$r.squared )
#X hist(qual)
dlply <- function(data., variables., fun. = NULL, ..., progress. = "none") {
  data. <- as.data.frame(data.)
  variables. <- as.quoted(variables.)
  pieces <- splitter_d(data., variables.)
  
  llply(pieces, fun., progress. = progress.)
}

alply <- function(data., margins., fun. = NULL, ..., progress. = "none") {
  pieces <- splitter_a(data., margins.)
  
  llply(pieces, fun., progress. = progress.)
}
