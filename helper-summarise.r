summarize <- summarise <- function(.data, ...) {
 eval(substitute(data.frame(...)), .data, parent.frame())
}