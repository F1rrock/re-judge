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
