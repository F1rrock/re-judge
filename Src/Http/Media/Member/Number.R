source("Src/Http/Media/Member/Member.R")
source("Src/Number/Number.R")

member.number <- function(x) {
  structure(
    list(
      origin = x
    ),
    class = "member_number"
  )
}

entry.member_number <- function(x) scalar(x$origin)
