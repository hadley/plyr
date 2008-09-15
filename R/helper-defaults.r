
# Set defaults
# Convient method for combining a list of values with their defaults.
# 
# @arguments list of values
# @arguments defaults
# @keyword manip 
defaults <- function(x, y)  {
  c(x, y[setdiff(names(y), names(x))])
} 
