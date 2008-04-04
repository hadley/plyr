# Dimensions
# Number of dimensions of an array or vector
# 
# @arguments array 
# @keyword internal
dims <- function(x) length(vdim(x))

# Dimensions
# Compute dimensions for a vector similarly to arrays
# 
# @arguments array or vector
# @keyword internal 
vdim <- function(x) if (is.vector(x)) length(x) else dim(x)
