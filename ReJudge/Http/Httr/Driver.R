source("ReJudge/Http/Driver/Driver.R")
source("ReJudge/Http/Request/Request.R")
source("ReJudge/Http/Httr/Request.R")
source("ReJudge/Http/Httr/Attachment.R")
source("ReJudge/Http/Httr/Connection.R")

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
