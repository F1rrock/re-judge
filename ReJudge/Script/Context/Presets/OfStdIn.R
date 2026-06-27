source("ReJudge/Script/Context/Empty.R")
source("ReJudge/Script/Context/StdIn/OfScan.R")
source("ReJudge/Script/Context/StdIn/OfReadLines.R")
source("ReJudge/Script/Context/StdIn/OfReadTable.R")

context.ofstdin <- context.ofreadtable( 
  context.ofreadlines(
    context.ofscan(
      context.empty
    )
  )
)
