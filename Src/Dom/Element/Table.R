source("Src/Dom/Engine/Engine.R")
source("Src/Dom/Element/Text.R")
source("Src/Text/Lambda.R")
source("Src/Collection/Map.R")

element.table <- function(dom) {
  cell <- element.text(dom, separator = " ")
  function(element) {
    text.lambda(function() {
      rows <- lapply(
        items(
          dom$children(element)
        ),
        function(row) lapply(
          items(
            dom$children(row)
          ), 
          function(c) contents(cell(c))
        )
      )
      if (length(rows) == 0) return(NA_character_)
      ncols  <- max(
        vapply(
          rows, length, integer(1)
        )
      )
      widths <- vapply(
        seq_len(ncols), 
        function(j) {
          max(
            vapply(
              rows, 
              function(r) {
                if (j <= length(r)) {
                  return(
                    nchar(r[[j]])
                  )
                }
                0L
              }, 
              integer(1)
            )
          )
        }, 
        integer(1)
      )
      fmt <- function(row) {
        paste(
          vapply(
            seq_len(ncols), 
            function(j) {
              formatC(
                if (j <= length(row)) row[[j]] else "", 
                width = widths[j], 
                flag = "-"
              )
            }, 
            character(1)
          ), 
          collapse = "  "
        )
      }
      paste(vapply(rows, fmt, character(1)), collapse = "\n")
    })
  }
}
