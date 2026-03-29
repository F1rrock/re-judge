source("Dom/Element/Element.R")

element.lambda <- function(f) {
  structure(
    list(
      callback = f
    ),
    class = "element_lambda"
  )
}

value.element_lambda <- function(x) x$callback()
