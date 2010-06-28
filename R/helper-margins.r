#' Figure out margining variables.
#' Given the variables that form the rows and columns, and a set of desired
#' margins, works out which ones are possible. Variables that can't be
#' margined over are dropped silently.
#'
#' @param col a character vector of column names
#' @param row a character vector of row names
#' @param margins a character vector of variable names to margin over.  Can be
#'   any variable name in \code{col} or \code{row}, \code{"grand_row"} or
#'   \code{"grand_col"}.  If \code{TRUE} will compute all possible margins.
#' @keywords manip internal
#' @return list of margining combinations, or \code{NULL} if none. These are
#'   the combinations of variables that should have their values set to 
#'   `(all)`
margins <- function(rows = NULL, cols = NULL, margins = NULL) {  
  if (is.null(margins) || identical(margins, FALSE)) return(NULL)
  if (isTRUE(margins)) {
    margins <- c(rows, cols, "grand_row", "grand_col")
  }
  
  # Nothing to margin over for last variable in column or row
  row.margins <- intersect(rows[-length(rows)], margins)
  if (length(row.margins) == 0 ) row.margins <- NULL
  col.margins <- intersect(cols[-length(cols)], margins)
  if (length(col.margins) == 0 ) col.margins <- NULL
  
  margin.intersect <- function(cols, col.margins, rows, row.margins) {
    unlist(lapply(col.margins, function(col) {
      c(lapply(row.margins, c, col), list(c(col, rows)))
    }), recursive = FALSE)
  }
  
  margin_vars <- c(
    margin.intersect(cols, col.margins, rows, row.margins),  
    margin.intersect(rows, row.margins, cols, col.margins)
  )

  grand.row <- "grand_row" %in% margins
  grand.col <- "grand_col" %in% margins
  if (grand.row && !is.null(rows)) {
    margin_vars <- compact(c(margin_vars, list(cols), list(col.margins)))
  }
  if (grand.col && !is.null(cols)) {
    margin_vars <- compact(c(margin_vars, list(rows), list(row.margins)))
  }
  
  # Do we need an overall total?
  rows_and_cols <- grand.col && grand.row && !is.null(rows) && !is.null(cols)
  just_rows <- grand.row && !is.null(rows) && is.null(cols)
  just_cols <- grand.col && !is.null(cols) && is.null(rows)
  if (rows_and_cols || just_rows || just_cols) {
    margin_vars <- c(margin_vars, list(c(rows, cols)))
  }
  
  # Remove duplicates
  duplicates <- duplicated(lapply(lapply(margin_vars, sort), paste,
    collapse = ""))
  margin_vars[!duplicates]
}

#' Add margins to a data frame.
#'
#' Rownames are silently stripped. All margining variables will be converted
#' to factors.
#'
#' @param df input data frame
#' @param rows names of row margins
#' @param cols names of column margins
#' @param margins Either \code{TRUE} to compute all margins, or a character
#'   vector of margin names, which may include any name in \code{rows} or
#'   \code{cols}, or \code{"grand_row"} or \code{"grand_col"}.
#' @export
add_margins <- function(df, rows = NULL, cols = NULL, margins = TRUE) {
  margin_vars <- margins(rows, cols, margins)
  
  # Return data frame if no margining necessary
  if (length(margin_vars) == 0) return(df)
  
  # Prepare data frame for addition of margins
  vars <- unique(unlist(margin_vars))
  df[vars] <- lapply(df[vars], function(x) 
    factor(x, levels = c(sort(unique(x)), "(all)")))
  rownames(df) <- NULL
  
  # Loop through all combinations of margin variables, setting
  # those variable to (all)
  margin_dfs <- ldply(margin_vars, function(vars) {
    df[vars] <- "(all)"
    unique(df)
  })
  
  rbind(df, margin_dfs)
}