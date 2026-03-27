source("Text/Text.R")
source("Media/Media.R")

media.c <- local({
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
      class = "media_c"
    )
  }
  this(stats::setNames(character(), character()))
})

src.media_c <- function(x) x$origin
