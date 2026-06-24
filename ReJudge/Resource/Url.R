source("ReJudge/Resource/Resource.R")
source("ReJudge/Text/Text.R")

resource.url <- function(url, target) {
  structure(
    list(url = url, target = target),
    class = "resource_url"
  )
}

download.resource_url <- function(x) {
  download.file(
    url = contents(x$url),
    destfile = contents(x$target),
    mode = "wb",
    quiet = TRUE
  )
}
