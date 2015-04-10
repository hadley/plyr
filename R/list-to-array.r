#' List to array.
#'
#' Reduce/simplify a list of homogenous objects to an array
#'
#' @param res list of input data
#' @param labels a data frame of labels, one row for each element of res
#' @param .drop should extra dimensions be dropped (TRUE) or preserved (FALSE)
#' @family list simplification functions
#' @keywords internal
list_to_array <- function(res, labels = NULL, .drop = FALSE) {
  if (length(res) == 0) return(vector())
  n <- length(res)

  atomic <- sapply(res, is.atomic)
  if (all(atomic) || all(!atomic)) {
    dlength <- unique.default(llply(res, dims))
    if (length(dlength) != 1)
      stop("Results must have the same number of dimensions.")

    dims <- unique(do.call("rbind", llply(res, amv_dim)))

    if (is.null(dims))
      stop("Results must have one or more dimensions.", call. = FALSE)
    if (nrow(dims) != 1)
      stop("Results must have the same dimensions.", call. = FALSE)

    res_dim <- amv_dim(res[[1]])
    res_labels <- amv_dimnames(res[[1]])
    if (any(vapply(res_labels, anyDuplicated, integer(1)) != 0)) {
      warning("Duplicate names not supported.", call. = FALSE)
    }
    res_index <- expand.grid(res_labels)

    res <- unlist(res, use.names = FALSE, recursive = FALSE)
  } else {
    stop("Results must have compatible types.")
  }

  if (is.null(labels)) {
    labels <- data.frame(X = seq_len(n))
    in_labels <- list(NULL)
    in_dim <- n
  } else {
    in_labels <- lapply(labels,
      function(x) if(is.factor(x)) levels(x) else sort(unique(x), na.last = TRUE))
    in_dim <- sapply(in_labels, length)
  }

  # Work out where each result should go in the new array
  index_old <- rep(id(rev(labels)), each = nrow(res_index))
  index_new <- rep(id(rev(res_index)), nrow(labels))
  index <- (index_new - 1) * prod(in_dim) + index_old

  out_dim <- unname(c(in_dim, res_dim))
  out_labels <- c(in_labels, res_labels)
  n <- prod(out_dim)

  if (length(index) < n) {
    overall <- match(1:n, index, nomatch = NA)
  } else {
    overall <- order(index)
  }

  out_array <- res[overall]
  dim(out_array) <- out_dim
  dimnames(out_array) <- out_labels
  if (.drop) reduce_dim(out_array) else out_array
}
