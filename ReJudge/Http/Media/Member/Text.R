source("ReJudge/Http/Media/Member/Member.R")
source("ReJudge/Text/Text.R")

member.text <- function(x) {
  structure(
    list(
      origin = x
    ),
    class = "member_text"
  )
}

entry.member_text <- function(x) contents(x$origin)
