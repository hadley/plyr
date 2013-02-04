#' Replicate expression and return results in a list of data frames.
#'
#' Evalulate expression n times then combine results into a list of data frames
#'
#' This function runs an expression multiple times, and combines the
#' result into a list of data frames.  If there are no results, then this function
#' returns an empty list.
#' This function is equivalent to \code{\link{replicate}}, but will always
#' return results as a data frame.
#'
#'
#' @keywords manip
#' @param .n number of times to evaluate the expression
#' @param .expr expression to evaluate
#' @param .progress name of the progress bar to use, see \code{\link{create_progress_bar}}
#' @return a list of data frame
#' @export
#' @examples
#' ## create the dataset
#' ## time from one visit to the next and one event to the next
#' ## are poisson distributed
#' createPatientData <- function(numVisits, aveVisitTime, numEvents, aveEventTime, patientId) {
#'   visits <- data.frame(visitNum=sequence(numVisits), visitDay=cumsum(rpois(numVisits, aveVisitTime)))
#'   events <- data.frame(eventNum=sequence(numEvents), eventDay=cumsum(rpois(numEvents, aveEventTime)))
#'   ## no event after last visit
#'   events <- subset(events, eventDay <= max(visits$visitDay))
#'   ## add patient Id
#'   visits$patientId <- rep(patientId, nrow(visits))
#'   events$patientId <- rep(patientId, nrow(events))  
#'   return(list(visits=visits, events=events))
#' }
#'
#" dataset <- rbply(20, {createPatientData(numVisits=10, aveVisitTime=10, numEvents=3, aveEventTime=30,
#'                                         patientId=NULL)})
#' dataset$visits$patientId <- dataset$visits$.n
#' dataset$events$patientId <- dataset$events$.n
#' dataset$visits$.n <- NULL; dataset$events$.n <- NULL

rbply <- function(.n, .expr, .progress = "none") {
  if (is.function(.expr)) {
    f <- .expr
  } else {
    f <- eval.parent(substitute(function() .expr))
  }

  res <- rlply(.n = .n, .expr = f, .progress = .progress)
  labels <- data.frame(.n = seq_len(.n))
  list_to_database(res, labels)
}
