source("ReJudge/Text/Text.R")
source("ReJudge/Text/Pretty.R")
source("ReJudge/Text/Interpolated.R")
source("ReJudge/Installation/Lambda.R")

installation.from <- function(src) {
  installation.lambda(
    function() {
      contents(
        text.pretty(
          text.interpolated(
            paste(
              deparse(
                quote({
                  src <- `@@`(src)
                  zip <- tempfile(fileext = ".zip")
                  download.file(src, zip, mode = "wb")
                  tmp <- file.path(tempdir(), "re-judge-setup")
                  unlink(tmp, recursive = TRUE, force = TRUE)
                  dir.create(tmp, showWarnings = FALSE, recursive = TRUE)
                  unzip(zip, exdir = tmp)
                  root <- list.dirs(tmp, recursive = FALSE, full.names = TRUE)[[1]]
                  files <- list.files(root, all.files = TRUE, no.. = TRUE, full.names = TRUE)
                  file.copy(from = files, to = ".", recursive = TRUE, overwrite = TRUE)
                })
              ),
              collapse = "\n"
            ),
            src = contents(src)
          )
        )
      )
    }
  )
}
