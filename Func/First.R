first <- function(default, xs) {
  if (length(xs) == 0) {
    return(default)
  }
  xs[[1]]
}
