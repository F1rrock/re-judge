source("Text/Text.R")
source("Http/Media/Media.R")
source("Http/Connection/Connection.R")

httr.connection <- function(method, url, headers, body, jar, encode) {
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
