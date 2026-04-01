source("Dom/Engine/Engine.R")
source("Dom/Element/Element.R")
source("Dom/Element/Lambda.R")
source("Collection/Lambda.R")
source("Text/Text.R")
source("Text/Lambda.R")

engine.xml2 <- structure(
  list(),
  class = "xml2_engine"
)

dom.xml2_engine <- function(x) {
  list(
    root = function(page) {
      element.lambda(function() {
        xml2::read_html(contents(page))
      })
    },
    selection = function(selector, element) {
      element.lambda(function() {
        rvest::html_element(
          node(element),
          css = contents(selector)
        )
      })
    },
    children = function(element) {
      collection.lambda(function() {
        xs <- xml2::xml_children(node(element))
        lapply(
          seq_along(xs),
          function(i) {
            j <- i
            element.lambda(function() xs[[j]])
          }
        )
      })
    },
    matches = function(selector, element) {
      n <- node(element)
      if (inherits(n, "xml_missing")) return(FALSE)
      parent <- xml2::xml_parent(n)
      if (inherits(parent, "xml_missing")) return(FALSE)
      xs <- rvest::html_elements(
        parent,
        css = contents(selector)
      )
      any(
        vapply(
          seq_along(xs),
          function(i) identical(xs[[i]], n),
          logical(1)
        )
      )
    },
    txt = function(element) {
      text.lambda(function() {
        xml2::xml_text(node(element), trim = TRUE)
      })
    }
  )
}
