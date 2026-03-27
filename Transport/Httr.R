library(httr)
source("Transport/Driver/Driver.R")
source("Transport/Connection/Connection.R")
source("Media/C.R")
source("Media/List.R")
source("Text/Text.R")

driver.httr <- structure(
  list(
    connection = function(method, url, headers, body, encode = "multipart") {
      structure(
        list(
          method  = method,
          url     = url,
          headers = headers,
          body    = body,
          encode  = encode
        ),
        class = "httr_connection"
      )
    }
  ),
  class = "httr_driver"
)

headers.httr_driver  <- function(x) media.c
body.httr_driver     <- function(x) media.list

response.httr_connection <- function(x) {
  r <- httr::VERB(
    contents(x$method), 
    url = contents(x$url), 
    body   = src(x$body),
    httr::add_headers(.headers = src(x$headers)), 
    encode = contents(x$encode)
  )
  list(
    html    = function() httr::content(r, "text", encoding = "UTF-8"),
    cookies = function() {
      cs <- httr::cookies(r)
      lapply(
        seq_len(nrow(cs)),
        function(i) {
          list(
            domain = cs$domain[[i]],
            flag = cs$flag[[i]],
            path = cs$path[[i]],
            secure = cs$secure[[i]],
            expiration = cs$expiration[[i]],
            name = cs$name[[i]],
            value = cs$value[[i]]
          )
        }
      )
    },
    status  = function() httr::status_code(r)
  )
}
