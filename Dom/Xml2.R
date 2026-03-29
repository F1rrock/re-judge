library(xml2)
library(rvest)
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
          value(element),
          css = contents(selector)
        )
      })
    },
    children = function(element) {
      collection.lambda(function() {
        xs <- xml2::xml_children(value(element))
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
      v <- value(element)
      if (inherits(v, "xml_missing")) return(FALSE)
      parent <- xml2::xml_parent(v)
      if (inherits(parent, "xml_missing")) return(FALSE)
      xs <- rvest::html_elements(
        parent,
        css = contents(selector)
      )
      any(
        vapply(
          seq_along(xs),
          function(i) identical(xs[[i]], v),
          logical(1)
        )
      )
    },
    txt = function(element) {
      text.lambda(function() {
        xml2::xml_text(value(element), trim = TRUE)
      })
    }
  )
}
