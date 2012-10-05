#' plyr
#'
#' @docType package
#' @name plyr
NULL


.onUnload <- function (libpath) {
  library.dynam.unload("plyr", libpath)
}
