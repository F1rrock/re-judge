source("Http/Media/Member/Member.R")
source("Text/Text.R")

member.text <- function(x) {
  structure(
    list(
      origin = x
    ),
    class = "member_text"
  )
}

entry.member_text <- function(x) contents(x$origin)
