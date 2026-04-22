source("Src/Dom/Element/Element.R")

element.delegate <- function(f) {
  structure(
    list(
      callback = f
    ),
    class = "element_delegate"
  )
}

node.element_delegate <- function(x) node(x$callback())
