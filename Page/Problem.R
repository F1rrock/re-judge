source("Text/Text.R")
source("Text/Fstring.R")
source("Text/Token.R")
source("Transport/Driver/Driver.R")
source("Transport/Connection/Presets/Ready.R")
source("Domain/Token/Ejsid.R")
source("Domain/Token/Sid.R")

page.problem <- function(driver, address) {
  function(session, id) {
    structure(
      list(
        connection = connection.ready(
          driver$connection(
            method = 'GET',
            url = text.fstring(
              "%s/ejudge/?SID=%s&action=139&prob_id=%s", 
              address, 
              text.token(
                "SID is required for fetching problem page",
                sid(session)
              ), 
              id
            ),
            headers = headers(driver)$
              with('Accept', paste0(
                'text/html,application/xhtml+xml,application/xml;q=0.9,',
                'image/avif,image/webp,image/apng,*/*;q=0.8,',
                'application/signed-exchange;v=b3;q=0.7'
                )
              ),
            jar = jar(driver)$with(
              'EJSID', 
              text.token(
                "EJSID is required for fetching problem page",
                ejsid(session)
              )
            )
          )
        )
      ),
      class = "page_problem"
    )
  }
}

contents.page_problem <- function(x) response(x$connection)$html()
