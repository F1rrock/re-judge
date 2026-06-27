source("ReJudge/Script/Context/Context.R")
source("ReJudge/Script/Context/Lambda.R")

context.ofscan <- function(origin) {
  context.lambda(
    function() {
      c(
        deparse(
          quote({
            scan = local({
              old <- base::scan
              function(...) {
                args <- list(...)
                if (!is.null(args$text)) {
                  txt <- args$text
                  args$text <- NULL
                  return(do.call(old, c(list(text = txt), args)))
                }
                if (is.null(args$file))
                  args$file <- "stdin"
                do.call(old, args)
              }
            })
          })
        ),
        core(origin)
      )
    }
  )
}
