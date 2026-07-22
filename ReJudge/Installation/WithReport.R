source("ReJudge/Text/Text.R")
source("ReJudge/Text/Interpolated.R")
source("ReJudge/Text/Pretty.R")
source("ReJudge/Installation/Installation.R")
source("ReJudge/Installation/Lambda.R")

installation.withreport <- function(origin) {
  installation.lambda(
    function() {
      contents(
        text.pretty(
          text.interpolated(
            paste(
              deparse(
                quote(
                  tryCatch(
                    {
                      `@@`(origin)
                    },
                    error = function(e) {
                      cat(
                        paste0(
                          "\014",
                          "\033[31m",
                          "Error: ", 
                          conditionMessage(e),
                          "\033[39m"
                        )
                      )
                    }
                  )
                )
              ),
              collapse = "\n"
            ),
            origin = code(origin)
          )
        )
      )
    }
  )
}
