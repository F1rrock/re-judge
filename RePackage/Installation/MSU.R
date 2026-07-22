source("RePackage/R/Bootstrap.R")

writeLines(
  {
    rejudge.load()
    code(
      installation.full(
        provider.msu,
        endpoint.msu,
        client.newclient
      )
    )
  },
  "RePackage/Installation/Fixtures/MSU.R"
)
