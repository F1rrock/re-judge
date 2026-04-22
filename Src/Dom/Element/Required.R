source("Src/Text/Text.R")
source("Src/Dom/Element/Element.R")

element.required <- function(e = 'required element is not defined', x) {
  structure(
    list(
      onerror = e,
      origin  = x
    ),
    class = "required_element"
  )
}

node.required_element <- function(x) {
  n <- node(x$origin)
  if (is.na(n)) {
    stop(contents(x$onerror))
  }
  n
}
