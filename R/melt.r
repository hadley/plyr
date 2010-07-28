#' Convert an object into a molten data frame.
#'
#' This the generic melt function. See the following functions
#' for the details about different data structures:
#'
#' \itemize{
#'   \item \code{\link{melt.data.frame}} for data.frames
#'   \item \code{\link{melt.array}} for arrays, matrices and tables
#'   \item \code{\link{melt.list}} for lists
#' }
#'
#' @keywords manip
#' @param data Data set to melt
#' @param ... further arguments passed to or from other methods.
#' @export
melt <- function(data, ...) UseMethod("melt", data)

#' Melt a vector.
#' For vectors, makes a column of a data frame
#'
#' @param data vector to melt
#' @param ... further arguments passed to or from other methods.
#' @S3method melt default
#' @method melt default
#' @keywords manip
melt.default <- function(data, ...) {
  data.frame(value = data)
}

#' Melt a list by recursively melting each component.
#' 
#' @keywords manip
#' @S3method melt list
#' @method melt list
#' @param data list to recursively melt
#' @param ... further arguments passed to or from other methods.
#' @param level list level - used for creating labels
#' @examples
#' a <- as.list(1:4)
#' melt(a)
#' names(a) <- letters[1:4]
#' melt(a)
#' a <- list(matrix(1:4, ncol=2), matrix(1:6, ncol=2))
#' melt(a)
#' a <- list(matrix(1:4, ncol=2), array(1:27, c(3,3,3)))
#' melt(a)
#' melt(list(1:5, matrix(1:4, ncol=2)))
#' melt(list(list(1:3), 1, list(as.list(3:4), as.list(1:2))))
melt.list <- function(data, ..., level = 1) {
  parts <- lapply(data, melt, level = level + 1, ...)
  
  labels <- data.frame(rep(amv_dimnames(data)[[1]], sapply(parts, nrow)))
  names(labels) <- paste("L", level, sep = "")
  
  res <- cbind(labels, rbind.fill(parts))
  res[, c(setdiff(names(res), "value"), "value")]
}

#' Melt a data frame
#' Melt a data frame into form suitable for easy casting.
#'
#' You need to tell melt which of your variables are id variables, and which
#' are measured variables. If you only supply one of \code{id.vars} and
#' \code{measure.vars}, melt will assume the remainder of the variables in the
#' data set belong to the other. If you supply neither, melt will assume
#' factor and character variables are id variables, and all others are
#' measured.
#'
#' @param data data frame to melt
#' @param id.vars vector of id variables. Can be integer (variable position)
#'   or string (variable name)If blank, will use all non-measured variables. 
#' @param measure.vars vector of measured variables. Can be integer (variable
#'   position) or string (variable name)If blank, will use all non id.vars
#    variables. 
#' @param variable.name name of variable used to store measured variable names
#' @param value.name name of variable used to store values
#' @param na.rm Should NA values be removed from the data set? This will 
#'   convert explicit missings to implicit missings.
#' @param ... further arguments passed to or from other methods.
#' @keywords manip
#' @method melt data.frame
#' @S3method melt data.frame
#' @examples
#' names(airquality) <- tolower(names(airquality))
#' melt(airquality, id=c("month", "day"))
#' names(ChickWeight) <- tolower(names(ChickWeight))
#' melt(ChickWeight, id=2:4)
melt.data.frame <- function(data, id.vars, measure.vars, variable.name = "variable", value.name = "value", na.rm = FALSE, ...) {
  var <- melt_check(data, id.vars, measure.vars)

  ids <- unrowname(data[, var$id, drop = FALSE])
  if (length(var$measure) == 0) {
    return(ids)
  }
  
  value <- unlist(unname(data[var$measure]))
  variable <- factor(rep(var$measure, each = nrow(data)), 
    levels = var$measure)
  
  df <- data.frame(ids, variable, value)
  names(df) <- c(names(ids), variable.name, value.name)

  if (na.rm) {
    subset(df, !is.na(value))
  } else {
    df
  }
}

#' Melt an array.
#'
#' This code is conceptually similar to \code{\link{as.data.frame.table}}
#' 
#' @param data array to melt
#' @param varnames variable names to use in molten data.frame
#' @param ... further arguments passed to or from other methods.
#' @keywords manip
#' @S3method melt matrix
#' @S3method melt array
#' @method melt array
#' @examples
#' a <- array(1:24, c(2,3,4))
#' melt(a)
#' melt(a, varnames=c("X","Y","Z"))
#' dimnames(a) <- lapply(dim(a), function(x) LETTERS[1:x])
#' melt(a)
#' melt(a, varnames=c("X","Y","Z"))
#' dimnames(a)[1] <- list(NULL)
#' melt(a)
melt.array <- function(data, varnames = names(dimnames(data)), ...) {
  var.convert <- function(x) if(is.character(x)) type.convert(x) else x

  dn <- amv_dimnames(data)
  names(dn) <- varnames
  labels <- expand.grid(lapply(dn, var.convert), KEEP.OUT.ATTRS = FALSE,
    stringsAsFactors = FALSE)

  data.frame(labels, value = as.vector(data))
}

melt.table <- melt.array
melt.matrix <- melt.array

#' Check that input variables to melt are appropriate.
#'
#' If id.vars or measure.vars are missing, \code{melt_check} will do its 
#' best to impute them. If you only supply one of id.vars and measure.vars,
#' melt will assume the remainder of the variables in the data set belong to
#' the other. If you supply neither, melt will assume discrete variables are
#' id variables and all other are measured.
#'
#' @param data data frame
#' @param id.vars vector of identifying variable names or indexes
#' @param measure.vars vector of Measured variable names or indexes
#' @return a list giving id and measure variables names.
melt_check <- function(data, id.vars, measure.vars) {
  varnames <- names(data)
  
  # Convert positions to names
  if (!missing(id.vars) && is.numeric(id.vars)) {
    id.vars <- varnames[id.vars]
  }
  if (!missing(measure.vars) && is.numeric(measure.vars)) {
    measure.vars <- varnames[measure.vars]
  }
  
  # Check that variables exist
  if (!missing(id.vars)) {
    unknown <- setdiff(id.vars, varnames)
    if (length(unknown) > 0) {
      vars <- paste(unknown, collapse=", ")
      stop("id variables not found in data: ", vars, call. = FALSE)
    }
  } 
  
  if (!missing(measure.vars)) {
    unknown <- setdiff(measure.vars, varnames)
    if (length(unknown) > 0) {
      vars <- paste(unknown, collapse=", ")
      stop("measure variables not found in data: ", vars, call. = FALSE)
    }
  } 

  # Fill in missing pieces
  if (missing(id.vars) && missing(measure.vars)) {
    discrete <- sapply(data, is.discrete)
    id.vars <- varnames[discrete]
    measure.vars <- varnames[!discrete]
    message("Using ", paste(id.vars, collapse = ", "), " as id variables")
  } else if (missing(id.vars)) {
    id.vars <- setdiff(varnames, measure.vars)
  } else if (missing(measure.vars)) {
    measure.vars <- setdiff(varnames, id.vars)
  }
  
  list(id = id.vars, measure = measure.vars)  
}
