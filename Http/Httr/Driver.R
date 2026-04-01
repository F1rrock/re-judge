source("Http/Driver/Driver.R")
source("Http/Request/Request.R")
source("Http/Httr/Request.R")
source("Http/Httr/Attachment.R")
source("Http/Httr/Connection.R")

httr.driver <- local({
  h <- headers(httr.request)
  b <- body(httr.request)
  j <- jar(httr.request)
  structure(
    list(
      connection = function(
        method, url, 
        headers = h, 
        body = b, 
        jar = j, 
        encode = "multipart"
      ) httr.connection(method, url, headers, body, jar, encode)
    ),
    class = "httr_driver"
  )
})

request.httr_driver    <- function(x) httr.request
attachment.httr_driver <- function(x) httr.attachment
