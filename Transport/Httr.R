library(httr)
source("Transport/Driver/Driver.R")
source("Transport/Connection/Connection.R")
source("Media/C.R")
source("Media/List.R")
source("Text/Text.R")

driver.httr <- structure(
  list(
    connection = function(
      method, url, 
      headers = media.c, 
      body = media.list, 
      jar = media.c, 
      encode = "multipart"
    ) {
      structure(
        list(
          method  = method,
          url     = url,
          headers = headers,
          body    = body,
          jar     = jar,
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
jar.httr_driver      <- function(x) media.c

response.httr_connection <- function(x) {
  r <- httr::VERB(
    verb   = contents(x$method), 
    url    = contents(x$url), 
    body   = src(x$body),
    httr::add_headers(.headers = src(x$headers)), 
    httr::set_cookies(.cookies = src(x$jar)),
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
