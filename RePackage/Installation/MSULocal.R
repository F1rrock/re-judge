source("RePackage/R/Bootstrap.R")

writeLines(
  {
    rejudge.load()
    code(
      installation.msulocal
    )
  },
  "RePackage/Installation/Fixtures/MSULocal.R"
)
