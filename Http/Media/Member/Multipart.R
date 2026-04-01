source("Text/Text.R")
source("Http/Attachment/Attachment.R")
source("Http/Driver/Driver.R")
source("Http/Media/Member/Member.R")

member.multipart <- function(driver, path) {
  structure(
    list(
      driver = driver,
      path   = path
    ),
    class = "member_multipart"
  )
}

entry.member_multipart <- function(x) {
  file <- multipart(attachment(x$driver))
  file(x$path)
}
