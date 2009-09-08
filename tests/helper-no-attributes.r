# Checks if equal to when all attributes stripped
is_equivalent_to <- function(expected) {
  attributes(expected) <- NULL
  function(actual) {
    attributes(actual) <- NULL
    equals(expected)(actual)
  }
  
}