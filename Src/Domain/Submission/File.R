source("Src/Text/Lambda.R")
source("Src/File/File.R")
source("Src/File/Name.R")
source("Src/File/Required.R")

submission.file <- function(file) {
  text.lambda(
    function() {
      path(
        file.required(
          "required submission file path is not defined",
          file
        )
      )
    }
  )
}
