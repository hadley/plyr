#' Combine data.frames by row, filling in missing columns.
#'
#' \code{rbind}s a list of data frames filling missing columns with NA.
#'
#' This is an enhancement to \code{\link{rbind}} that adds in columns
#' that are not present in all inputs, accepts a list of data frames, and
#' operates substantially faster.
#'
#' Column names and types in the output will appear in the order in which
#' they were encountered.
#'
#' Unordered factor columns will have their levels unified and
#' character data bound with factors will be converted to
#' character. POSIXct data will be converted to be in the same time
#' zone. Array and matrix columns must have identical dimensions after
#' the row count. Aside from these there are no general checks that
#' each column is of consistent data type.
#'
#' @param ... input data frames to row bind together.  The first argument can
#'   be a list of data frames, in which case all other arguments are ignored.
#'   Any NULL inputs are silently dropped. If all inputs are NULL, the output
#'   is NULL.
#' @keywords manip
#' @family binding functions
#' @return a single data frame
#' @export rbind.fill
#' @examples
#' rbind.fill(mtcars[c("mpg", "wt")], mtcars[c("wt", "cyl")])
rbind.fill <- function(...) {
  dfs <- list(...)
  if (length(dfs) == 0) return()
  if (is.list(dfs[[1]]) && !is.data.frame(dfs[[1]])) {
    dfs <- dfs[[1]]
  }
  dfs <- compact(dfs)

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
  ot <- output_template(dfs, nrows)
  setters <- ot$setters
  getters <- ot$getters

  # Case of zero column inputs
  if (length(setters) == 0) {
    return(as.data.frame(matrix(nrow = nrows, ncol = 0)))
  }

  # Compute start and length for each data frame
  pos <- matrix(c(cumsum(rows) - rows + 1, rows), ncol = 2)

  # Copy inputs into output
  for (i in seq_along(rows)) {
    rng <- seq(pos[i, 1], length.out = pos[i, 2])
    df <- dfs[[i]]

    for (var in names(df)) {
      setters[[var]](rng, df[[var]]) # nolint
    }
  }

  quickdf(lapply(getters, function(x) x()))
}

# Construct named lists of setters and getters.
output_template <- function(dfs, nrows) {
  vars <- unique(unlist(lapply(dfs, base::names)))   # ~ 125,000/s
  output <- vector("list", length(vars))
  names(output) <- vars

  seen <- rep(FALSE, length(output))
  names(seen) <- vars

  for (df in dfs) {
    matching <- intersect(names(df), vars[!seen])
    for (var in matching) {
      output[[var]] <- allocate_column(df[[var]], nrows, dfs, var)
    }

    seen[matching] <- TRUE
    if (all(seen)) break  # Quit as soon as all done
  }

  list(setters=lapply(output, `[[`, "set"),
       getters=lapply(output, `[[`, "get"))
}

# Allocate space for a column to be filled out by rbind.fill.
#
# @param example An example vector taken from the first data frame
# @param nrows The number of rows
# @param dfs The list of data frames that will be combined. This may
# need to be scanned (to unify factor levels or check array dimension
# consistency)
# @param var The name of the column.
#
# @return A list of two accessor functions `list(set=<>, get=<>)`.
# `.$set(rows, value)` stores data in the given rows.
# `.$get()` retreives the column data.
allocate_column <- function(example, nrows, dfs, var) {
  #Compute the attributes of the column and allocate.  Returns a
  #mutator function f(rows, values) rather than the actual allocated
  #column.

  a <- attributes(example)
  type <- typeof(example)
  class <- a$class
  isList <- is.recursive(example)

  a$names <- NULL
  a$class <- NULL

  if (is.data.frame(example)) {
    stop("Data frame column '", var, "' not supported by rbind.fill")
  }

  if (is.array(example)) {
    if (length(dim(example)) > 1) {
      if ("dimnames" %in% names(a)) {
        a$dimnames[1] <- list(NULL)
        if (!is.null(names(a$dimnames)))
            names(a$dimnames)[1] <- ""
      }

      # Check that all other args have consistent dims
      df_has <- vapply(dfs, function(df) var %in% names(df), FALSE)
      dims <- unique(lapply(dfs[df_has], function(df) dim(df[[var]])[-1]))
      if (length(dims) > 1)
          stop("Array variable ", var, " has inconsistent dims")

      a$dim <- c(nrows, dim(example)[-1])
      length <- prod(a$dim)
    } else {
      #1d arrays devolve into vectors
      a$dim <- NULL
      a$dimnames <- NULL
      length <- nrows
    }
  } else {
    length <- nrows
  }

  if (is.factor(example)) {
    df_has <- vapply(dfs, function(df) var %in% names(df), FALSE)
    isfactor <- vapply(dfs[df_has], function(df) is.factor(df[[var]]), FALSE)
    if (all(isfactor)) {
      #will be referenced by the mutator
      levels <- unique(unlist(lapply(dfs[df_has],
                                     function(df) levels(df[[var]]))))
      a$levels <- levels
      handler <- "factor"
    } else {
      #fall back on character
      type <- "character"
      handler <- "character"
      class <- NULL
      a$levels <- NULL
    }
  } else if (inherits(example, "POSIXt")) {
    tzone <- attr(example, "tzone")
    class <- c("POSIXct", "POSIXt")
    type <- "double"
    handler <- "time"
  } else {
    handler <- type
  }

  column <- vector(type, length)
  if (!isList) {
    column[] <- NA
  }
  attributes(column) <- a

  #construct an assignment expression like `column[rows, ...] <- what`
  #appropriate for the number of dims
  assignment <- make_assignment_call(length(a$dim))

  #It is especially important never to inspect the column when in the
  #main rbind.fill loop. To avoid that, we've done specialization
  #(figuring out the array assignment form and data type) ahead of
  #time, and instead of returning the column, we return accessor
  #functions that close over the column.
  setter <- switch(
      handler,
      character = function(rows, what) {
        what <- as.character(what)
        eval(assignment)
      },
      factor = function(rows, what) {
        #duplicate what `[<-.factor` does
        what <- match(what, levels)
        #no need to check since we already computed levels
        eval(assignment)
      },
      time = function(rows, what) {
        what <- as.POSIXct(what, tz = tzone)
        eval(assignment)
      },
      function(rows, what) {
        eval(assignment)
      })

  getter <- function() {
    class(column) <<- class
    column
  }

  list(set=setter, get=getter)
}

#construct an assignment expression like `column[rows, ...] <- what`
#appropriate for the number of dims
make_assignment_call <- function(ndims) {
  assignment <- quote(column[rows] <<- what)
  if (ndims >= 2) {
    assignment[[2]] <- as.call(
        c(as.list(assignment[[2]]),
          rep(list(quote(expr = )), ndims - 1)))
  }
  assignment
}
