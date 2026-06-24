source("ReJudge/Resource/Resource.R")
source("ReJudge/Collection/Collection.R")
source("ReJudge/Script/Script.R")

script.withresources <- function(origin, resources) {
  structure(list(origin = origin, resources = resources), class = "script_withresources")
}

result.script_withresources <- function(x) {
  for (resource in items(x$resources)) {
    download(resource)
  }
  result(x$origin)
}
