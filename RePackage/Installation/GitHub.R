source("RePackage/R/Bootstrap.R")

writeLines(
  {
    rejudge.load()
    code(
      installation.github
    )
  },
  "RePackage/Installation/Fixtures/GitHub.R"
)
