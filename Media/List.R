source("Text/Text.R")
source("Media/Media.R")

media.list <- local({
  this <- function(x) {
    structure(
      base::list(
        origin = x,
        with = function(key, val) {
          out <- x
          out[[contents(key)]] <- contents(val)
          this(out)
        }
      ),
      class = "media_list"
    )
  }
  this(base::list())
})

src.media_list <- function(x) x$origin
