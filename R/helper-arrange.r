arrange <- function(df, ...) {
  ord <- eval(substitute(order(...)), df, parent.frame())
  df[ord, ]
}