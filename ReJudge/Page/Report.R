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

page.report <- function(driver, address, client) {
  request <- request(driver)
  function(session, id) {
    structure(
      list(
        connection = connection.ready(
          driver$connection(
            method = 'GET',
            url = text.fstring(
              "%s/%s/?SID=%s&action=37&run_id=%s", 
              address, 
              client,
              text.required(
                "SID is missing",
                text.token(
                  token.sid(session)
                )
              ), 
              id
            ),
            headers = headers(request)$
              with('Accept', member.text(paste0(
                'text/html,application/xhtml+xml,application/xml;q=0.9,',
                'image/avif,image/webp,image/apng,*/*;q=0.8,',
                'application/signed-exchange;v=b3;q=0.7'
              ))
              ),
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
      class = "page_report"
    )
  }
}

contents.page_report <- function(x) response(x$connection)$payload()
