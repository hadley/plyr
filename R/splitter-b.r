#' Split an environment (or a list) of data frame by variables.
#'
#' Split an environment of data frame into pieces based on variable contained in
#' the data frames
#'
#' This is the workhorse of the \code{e*ply} functions.  Based on the variables
#' you supply, it breaks up a every data frame in the environment into a list of lists of data frames,
#' where the inner lists contain the subsets fo the dataframes containing a single
#' combination from the levels of the specified variables.
#'
#' @seealso \code{\link{.}} for quoting variables, \code{\link{split}}
#' @family splitter functions
#' @param data an environment of data frames or a list of data frames
#' @param .variables a \link{quoted} list of variables
#' @param drop drop unnused factor levels?
#' @param ignoreIfNotAllVars ignore data frame if not all variables occur in the data frame
#' @return a list of lists of data.frames, with attributes that record split details
#' @keywords internal
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
#' 
#' res <- plyr:::splitter_b(dataset, as.quoted("patientId"))

splitter_b <- function(data, .variables = NULL, drop = TRUE) {
  stopifnot(is.quoted(.variables))

  ## get the true variable names
  vars <- unlist(lapply(.variables, all.vars))

  ## check which elements fo data are data frames with the required variables
  ## and select only those
  is_df_withVars <- unlist(lapply(data, function(x, vars) {return(is.data.frame(x) & all(vars %in% names(x)))},
                           vars=vars))
  data <- data[is_df_withVars]

  ## collect the identifying variables from every all data frames and generate the split_labels
  df_rows <- unlist(lapply(data, nrow))
  if(length(.variables) == 0) {
    splitv <- rep(1, sum(df_rows))
    split_labels <- NULL
    attr(splitv, "n") <- max(splitv)
  }
  else {
    splits <- rbind.fill(lapply(data, function(x, .variables) {
      as.data.frame(eval.quoted(.variables, x))},
                                .variables=.variables))
    splitv <- id(splits, drop=drop)
    split_labels <- split_labels(splits, drop=drop, id=splitv)
  }

  ## now make all the data frames in data into indexed df
  ## for that, get the indices for every data frame in data (extract appropriate parts of splitv)
  index_list <- lapply(split(as.integer(splitv), rep(1:length(df_rows), times=df_rows)),
                       split_indices, n=attr(splitv, "n"))

  idfl <- indexed_df_list(data, index_list, vars, attr(splitv, "n"))

  return(structure(idfl, class=c(class(idfl), "split", "list"),
                   split_type="database",
                   split_labels=split_labels))

}




