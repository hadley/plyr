library(iterators)
icanhasnext <- function(iterator) {
  # If already has hasNext function return iterator unchanged
  if (!is.null(iterator$hasNext)) return(iterator)
  
  cache <- NULL
  has_next <- NA
  
  nextElem <- function() {
    if (!hasNext()) end_iteration()
    
    # Return value and reset cache
    has_next <<- NA
    cache
  }
  
  hasNext <- function() {
    if (!is.na(has_next)) return(has_next)
    
    tryCatch({
      cache <<- iterator$nextElem()
      has_next <<- TRUE
    },
    error = function(e) {
      if (iteration_has_ended(e)) {
        has_next <<- FALSE
      } else {
        stop(e)
      }
    })
    
    has_next
  }
  
  new_iterator(nextElem, hasNext = hasNext)
}
end_iteration <- function() stop('StopIteration', call.=FALSE)
iteration_has_ended <- function(e) {
  identical(conditionMessage(e), 'StopIteration')
}
new_iterator <- function(nextElem, ...) {
  structure(list(nextElem=nextElem, ...), class=c('abstractiter', 'iter'))
}

is.iterator <- function(x) inherits(x, "iter")