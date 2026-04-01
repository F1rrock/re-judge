source("Http/Attachment/Attachment.R")
source("Text/Text.R")

httr.attachment <- structure(
  list(),
  class = "httr_attachment"
)

multipart.httr_attachment  <- function(x) {
  function(path) httr::upload_file(contents(path))
}
