source("Src/Http/Request/Request.R")
source("Src/Http/Media/C.R")
source("Src/Http/Media/List.R")

httr.request <- structure(
  list(),
  class = "httr_request"
)
  
headers.httr_request  <- function(x) media.c
body.httr_request     <- function(x) media.list
jar.httr_request      <- function(x) media.c
