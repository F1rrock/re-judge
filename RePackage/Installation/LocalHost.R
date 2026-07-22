source("RePackage/R/Bootstrap.R")

writeLines(
  {
    rejudge.load()
    code(
      installation.full(
        provider.localhost,
        endpoint.localhost,
        client.ejudge
      )
    )
  },
  "RePackage/Installation/Fixtures/LocalHost.R"
)
