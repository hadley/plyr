#' Combine data.frames by row, filling in missing columns.
#'
#' \code{rbind}s a list of data frames filling missing columns with NA.
#'
#' This is an enhancement to \code{\link{rbind}} that adds in columns
#' that are not present in all inputs, accepts a list of data frames, and
#' operates substantially faster.
#'
#' Column names and types in the output will appear in the order in which
#' they were encountered. No checking is performed to ensure that each column
#' is of consistent type in the inputs.
#'
#' @param ... input data frames to row bind together.  The first argument can
#'   be a list of data frames, in which case all other arguments are ignored.
#' @keywords manip
#' @family binding functions
#' @return a single data frame
#' @export
#' @examples
#' rbind.fill(mtcars[c("mpg", "wt")], mtcars[c("wt", "cyl")])
rbind.fill <- function(...) {
  dfs <- list(...)
  if (length(dfs) == 0) return()
  if (is.list(dfs[[1]]) && !is.data.frame(dfs[[1]])) {
    dfs <- dfs[[1]]
  }

  if (length(dfs) == 0) return()
  if (length(dfs) == 1) return(dfs[[1]])

  # Check that all inputs are data frames
  is_df <- vapply(dfs, is.data.frame, logical(1))
  if (any(!is_df)) {
    stop("All inputs to rbind.fill must be data.frames", call. = FALSE)
  }

  # Calculate rows in output
  # Using .row_names_info directly is about 6 times faster than using nrow
  rows <- unlist(lapply(dfs, .row_names_info, 2L))
  nrows <- sum(rows)

  # Generate output template
  output <- output_template(dfs, nrows)
  # Case of zero column inputs
  if (length(output) == 0) {
    return(as.data.frame(matrix(nrow = nrows, ncol = 0)))
  }

  # Compute start and length for each data frame
  pos <- matrix(c(cumsum(rows) - rows + 1, rows), ncol = 2)

  # Copy inputs into output
  for(i in seq_along(rows)) {
    rng <- seq(pos[i, 1], length = pos[i, 2])
    df <- dfs[[i]]

    for(var in names(df)) {
      if (!is.matrix(output[[var]])) {
        if (is.factor(output[[var]]) && is.character(df[[var]])) {
          output[[var]] <- as.character(output[[var]])
        }
        output[[var]][rng] <- df[[var]]
      } else {
        output[[var]][rng, ] <- df[[var]]
      }
    }
  }

  quickdf(output)
}

output_template <- function(dfs, nrows) {
  vars <- unique(unlist(lapply(dfs, base::names)))   # ~ 125,000/s
  output <- vector("list", length(vars))
  names(output) <- vars

  seen <- rep(FALSE, length(output))
  names(seen) <- vars

  is_array <- seen
  is_matrix <- seen
  is_factor <- seen

  for(df in dfs) {
    matching <- intersect(names(df), vars[!seen])
    for(var in matching) {
      value <- df[[var]]

      if (is.vector(value) && is.atomic(value)) {
        output[[var]] <- rep(NA, nrows)
      } else if (is.factor(value)) {
        output[[var]] <- factor(rep(NA, nrows), ordered = is.ordered(value))
        is_factor[var] <- TRUE
      } else if (is.matrix(value)) {
        is_matrix[var] <- TRUE
      } else if (is.array(value)) {
        is_array[var] <- TRUE
      } else if (inherits(value, "POSIXt")) {
        output[[var]] <- as.POSIXct(rep(NA, nrows))
        attr(output[[var]], "tzone") <- attr(value, "tzone")
      } else if (is.list(value)) {
        output[[var]] <- vector("list", nrows)
      } else {
        output[[var]] <- rep(NA, nrows)
        class(output[[var]]) <- class(value)
        attributes(output[[var]]) <- attributes(value)
      }
    }

    seen[matching] <- TRUE
    if (all(seen)) break  # Quit as soon as all done
  }

  # Set up factors
  for(var in vars[is_factor]) {
    all <- unique(lapply(dfs, function(df) levels(df[[var]])))
    output[[var]] <- factor(output[[var]], levels = unique(unlist(all)),
      exclude = NULL)
  }

  # Set up matrices
  for(var in vars[is_matrix]) {
    width <- unique(unlist(lapply(dfs, function(df) ncol(df[[var]]))))
    if (length(width) > 1)
      stop("Matrix variable ", var, " has inconsistent widths")

    vec <- rep(NA, nrows * width)
    output[[var]] <- array(vec, c(nrows, width))
  }

  # Set up arrays
  for (var in vars[is_array]) {
    dims <- unique(unlist(lapply(dfs, function(df) dims(df[[var]]))))
    if (any(dims) > 1) {
      stop("rbind.fill can only work with 1d arrays")
    }

    output[[var]] <- rep(NA, nrows)
  }

  output
}
