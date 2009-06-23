# Summarise a data frame.
# Create a new data frame that summarises an existing data frame.
# 
# Summarise works in an analagous way to transform, except instead of adding
# columns to an existing data frame, it creates a new one.  This is
# particularly useful in conjunction with \code{\link{ddply}} as it makes it
# easy to perform group-wise summaries.
# 
# @arguments The data frame to be summarised
# @arguments Further arguments of the form var = value
#X summarise(baseball, 
#X  duration = max(year) - min(year), 
#X  nteams = length(unique(team)))
#X ddply(baseball, "id", summarise, 
#X  duration = max(year) - min(year), 
#X  nteams = length(unique(team)))
summarize <- summarise <- function(`_data`, ...) {
 eval(substitute(data.frame(...)), `_data`, parent.frame())
}

# Alternative names: tally? sketch? abstract? abbreviate?
