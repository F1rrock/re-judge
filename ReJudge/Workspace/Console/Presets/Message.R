source("ReJudge/Text/Presets/Fresh.R")
source("ReJudge/Workspace/Console/Write.R")
source("ReJudge/Workspace/Console/WithReport.R")

console.message <- function(msg) {
  console.withreport(
    console.write(
      text.fresh(msg)
    )
  )
}
