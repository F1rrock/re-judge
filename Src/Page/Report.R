source("Src/Text/Text.R")
source("Src/Text/Fstring.R")
source("Src/Text/Token.R")
source("Src/Text/Required.R")
source("Src/Http/Driver/Driver.R")
source("Src/Http/Request/Request.R")
source("Src/Http/Connection/Presets/Ready.R")
source("Src/Http/Media/Member/Text.R")
source("Src/Domain/Token/Ejsid.R")
source("Src/Domain/Token/Sid.R")

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
