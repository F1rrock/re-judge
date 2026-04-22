source("Src/Text/Text.R")
source("Src/Http/Media/Media.R")
source("Src/Http/Media/Member/Member.R")

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

data.media_c <- function(x) x$origin
