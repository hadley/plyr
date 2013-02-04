#' Call function with arguments in array or data frame, returning a list of data frames.
#'
#' Call a multi-argument function with values taken from columns of an
#' data frame or array, and combine results into a data frame
#'
#' @template ply
#' @template m-
#' @template -b
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
#' dataset <- mbply(data.frame(patientId=1:20, numEvents=rpois(20,2)),
#'                  createPatientData, numVisits=10,
#'                  aveVisitTime=10, aveEventTime=30, .expand=FALSE)
#' dataset$visits$X1 <- NULL; dataset$events$X1 <- NULL


mbply <- function(.data, .fun = NULL, ..., .expand = TRUE, .progress = "none",
                  .inform = FALSE, .parallel = FALSE, .paropts = NULL) {
  if (is.matrix(.data) & !is.list(.data)) .data <- .matrix_to_df(.data)

  f <- splat(.fun)
  abply(.data = .data, .margins = 1, .fun = f, ...,
    .expand = .expand, .progress = .progress, .inform = .inform,
    .parallel = .parallel, .paropts = .paropts)
}
