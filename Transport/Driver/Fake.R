source("Transport/Driver/Driver.R")

driver.fake = function(h, b, j) {
  structure(
    list(
      headers = h,
      body = b,
      jar = j,
    ),
    class = "fake_driver"
  )
}

headers.fake_driver  <- function(x) x$headers
body.fake_driver     <- function(x) x$body
jar.fake_driver      <- function(x) x$jar
