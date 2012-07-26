#' plyr
#'
#' @docType package
#' @name plyr
#' @aliases plyr plyr-package
NULL


.onUnload <- function (libpath) {
  library.dynam.unload("plyr", libpath)
}
