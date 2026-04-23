source("ReJudge/Text/Text.R")
source("ReJudge/Http/Media/Media.R")
source("ReJudge/Http/Media/Member/Member.R")

media.list <- local({
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
      class = "media_list"
    )
  }
  this(base::list())
})

data.media_list <- function(x) x$origin
