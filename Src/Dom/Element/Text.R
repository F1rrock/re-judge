source("Src/Dom/Engine/Engine.R")
source("Src/Text/Join.R")
source("Src/Collection/Map.R")

element.text <- function(dom, separator) {
  self <- function(element) {
    children <- items(dom$children(element))
    if (length(children) == 0) {
      dom$txt(element)
    } else {
      text.join(
        separator,
        collection.map(self, dom$children(element))
      )
    }
  }
  self
}
