source("Text/Text.R")
source("Http/Media/Media.R")
source("Http/Media/Member/Member.R")

media.c <- local({
  this <- function(x) {
    structure(
      base::list(
        origin = x,
        with = function(key, val) {
          out <- x
          out[[contents(key)]] <- entry(val)
          this(out)
        }
      ),
      class = "media_c"
    )
  }
  this(stats::setNames(character(), character()))
})

src.media_c <- function(x) x$origin
