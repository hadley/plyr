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
      output[[var]](rng, df[[var]])
    }
  }

  quickdf(lapply(output, function(x) x()))
}

factor_to_char_preserving_attrs <- function(x) {
  a <- attributes(x)
  a[c("levels", "class")] <- NULL
  x <- as.character(x)
  mostattributes(x) <- a
  x
}

output_template <- function(dfs, nrows) {
  vars <- unique(unlist(lapply(dfs, base::names)))   # ~ 125,000/s
  output <- vector("list", length(vars))
  names(output) <- vars

  seen <- rep(FALSE, length(output))
  names(seen) <- vars

  for(df in dfs) {
    matching <- intersect(names(df), vars[!seen])
    for(var in matching) {
      output[[var]] <- allocate_column(df[[var]], nrows, dfs, var)
    }

    seen[matching] <- TRUE
    if (all(seen)) break  # Quit as soon as all done
  }

  output
}

allocate_column <- function(example, nrows, dfs, var) {
  #Compute the attributes of the column and allocate.
  #To avoid multiple allocations, never _inspect_ column after allocating
  #it. Inspection, even something as innocuous as is.matrix(column),
  #will  setting NAMED to 2 and forcing a copy on the
  #next modification.
  type <- typeof(example)
  handler <- type
  if (inherits(example, "POSIXt")) {
    #this should get folded in to general attribute handling as well...
    tzone <- attr(example, "tzone")
    column <- structure(as.POSIXct(rep(NA, nrows)), tzone=tzone)
  } else {
    a <- attributes(example)
    a$names <- NULL
    isList <- is.recursive(example)
    if (is.array(example)) {
      # Check that all other args have consistent dims
      df_has <- vapply(dfs, function(df) var %in% names(df), FALSE)
      dims <- unique(lapply(dfs[df_has], function(df) dim(df[[var]])[-1]))
      if (length(dims) > 1)
          stop("Array variable ", var, " has inconsistent dims")
      if (length(dims[[1]]) == 0) { #is dropping dims necessary for 1d arrays?
        a$dim <- NULL
      } else {
        a$dim <- c(nrows, dim(example)[-1])
      }
      a$dimnames <- NULL
      length <- prod(a$dim)
    } else {
      length <- nrows
    }

    if (is.factor(example)) {
      df_has <- vapply(dfs, function(df) var %in% names(df), FALSE)
      isfactor <- vapply(dfs[df_has], function(df) is.factor(df[[var]]), FALSE)
      if (!all(isfactor)) {
        type <- "character"
        handler <- "character"
        a$class <- NULL
        a$levels <- NULL
      } else {
        a$levels <- unique(unlist(lapply(dfs[df_has],
                                         function(df) levels(df[[var]]))))
        handler <- "factor"
      }
    }

    column <- vector(type, length)
    #tracemem(column)
    if (!isList) {
      column[] <- NA
    }
    attributes(column) <- a
  }

  # Check that all inputs are factors, and combine levels (or convert to char)

  #Return a mutator.
  #It is especially important never to inspect the column in the mutator.
  # To avoid inspecting the column, return a specialized mutator.
  switch(
      handler,
      character = function(rows, what) {
        if (nargs() == 0) return(column)
        if (is.matrix(column)) {
          column[rows, ] <<- as.character(what)
        } else {
          column[rows] <<- as.character(what)
        }
      },
      factor = function(rows, what) {
        if(nargs() == 0) return(column)
        if (is.matrix(column)) {
          column[rows, ] <<- as.character(what)
        } else {
          column[rows] <<- as.character(what)
        }
      },
      function(rows, what) {
        if(nargs() == 0) return(column)
        if (is.matrix(column)) {
          column[rows, ] <<- what
        } else {
          column[rows] <<- what
        }
      }
      )
}
