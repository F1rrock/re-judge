source("ReJudge/Http/Request/Request.R")
source("ReJudge/Http/Media/C.R")
source("ReJudge/Http/Media/List.R")

httr.request <- structure(
  list(),
  class = "httr_request"
)
  
headers.httr_request  <- function(x) media.c
body.httr_request     <- function(x) media.list
jar.httr_request      <- function(x) media.c
