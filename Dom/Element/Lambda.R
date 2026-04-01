source("Dom/Element/Element.R")

element.lambda <- function(f) {
  structure(
    list(
      callback = f
    ),
    class = "element_lambda"
  )
}

node.element_lambda <- function(x) x$callback()
