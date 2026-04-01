source("Http/Request/Request.R")
source("Http/Media/C.R")
source("Http/Media/List.R")

httr.request <- structure(
  list(),
  class = "httr_request"
)
  
headers.httr_request  <- function(x) media.c
body.httr_request     <- function(x) media.list
jar.httr_request      <- function(x) media.c
