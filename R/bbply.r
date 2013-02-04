#' Split list of data frames, apply function, and return results in a list of data frames.
#'
#' For each subset of a data frame, apply function then combine results into a
#' data frame.
#'
#' @template ply
#' @template b-
#' @template -b
#' @export
#' @examples
#' ## create the dataset
#' ##' time from one visit to the next and one event to the next
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
#' 
#' ## for every visit and every patient, calculate time from last event
#' daysSinceLastEvent <- function(visits, events) {
#'   events <- sort(unique(c(0, events))) # each day only counts once, sorted
#'   visits <- visits[visits>=0] # only visits after start of study count
#'   lastEvent <- events[findInterval(visits, events)]
#'  return(visits-lastEvent)
#' }
#' 
#' ## now, for every visit, calculate the time since last event and for every event, the time since last visit
#' ## assumes that it is data from a single patient
#' evalPatient <- function(data) {
#'   data$visits$daysSinceLastEvent <- daysSinceLastEvent(data$visits$visitDay, data$events$eventDay)
#'   data$events$timeSinceLastEvent <- diff(c(0,data$events$eventDay))
#'   return(data)
#' }
#' res <- bbply(dataset, "patientId", evalPatient)

bbply <- function(.data, .variables, .fun = NULL, ..., .progress = "none",
                  .inform = FALSE, .drop = TRUE, .parallel = FALSE,
                  .paropts = NULL) {
  if(is.null(.data)) return(.data)
  .variables <- as.quoted(.variables)
  pieces <- splitter_b(.data, .variables, drop = .drop)

  lbply(.data = pieces, .fun = .fun, ...,
    .progress = .progress, .inform = .inform,
    .parallel = .parallel, .paropts = .paropts)
}
