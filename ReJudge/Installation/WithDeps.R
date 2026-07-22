source("ReJudge/Installation/Installation.R")
source("ReJudge/Installation/Lambda.R")

installation.withdeps <- function(origin) {
  installation.lambda(
    function() {
      paste(
        paste(
          deparse(
            quote({
              required <- c("dotenv", "httr", "xml2", "rvest", "jsonlite", "rstudioapi")
              missing <- required[!vapply(required, requireNamespace, logical(1), quietly = TRUE)]
              if (length(missing) > 0) {
                install.packages(missing, repos = "https://cran.rstudio.com", type = "binary")
              }
              failed <- required[!vapply(required, requireNamespace, logical(1), quietly = TRUE)]
              if (length(failed) > 0) {
                stop("Failed to install required dependencies: ", paste(failed, collapse = ", "))
              }
            })
          ),
          collapse = "\n"
        ),
        code(origin),
        sep = "\n"
      )
    }
  )
}
