source("ReJudge/Text/Lambda.R")
source("ReJudge/File/File.R")
source("ReJudge/File/Name.R")
source("ReJudge/File/Required.R")

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
