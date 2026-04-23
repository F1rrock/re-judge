source("ReJudge/Text/Text.R")
source("ReJudge/Text/Fstring.R")
source("ReJudge/Text/Token.R")
source("ReJudge/Text/Required.R")
source("ReJudge/Http/Driver/Driver.R")
source("ReJudge/Http/Request/Request.R")
source("ReJudge/Http/Connection/Presets/Ready.R")
source("ReJudge/Http/Media/Member/Text.R")
source("ReJudge/Domain/Token/Ejsid.R")
source("ReJudge/Domain/Token/Sid.R")

page.status <- function(driver, address, client) {
  request <- request(driver)
  function(session) {
    structure(
      list(
        connection = connection.nocache(
          driver$connection(
            method = 'GET',
            url = text.fstring(
              "%s/%s?SID=%s&action=175&x=1", 
              address, 
              client,
              text.required(
                "SID is missing",
                text.token(
                  token.sid(session)
                )
              )
            ),
            headers = headers(request)$
              with('Accept', member.text('application/json, text/javascript, */*; q=0.01')),
            jar = jar(request)$with(
              'EJSID', 
              member.text(
                text.required(
                  "EJSID is missing",
                  text.token(
                    token.ejsid(session)
                  )
                )
              )
            )
          )
        )
      ),
      class = "page_status"
    )
  }
}

contents.page_status <- function(x) response(x$connection)$payload()
