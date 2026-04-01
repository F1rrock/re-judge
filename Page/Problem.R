source("Text/Text.R")
source("Text/Fstring.R")
source("Text/Token.R")
source("Http/Driver/Driver.R")
source("Http/Request/Request.R")
source("Http/Connection/Presets/Ready.R")
source("Http/Media/Member/Text.R")
source("Domain/Token/Ejsid.R")
source("Domain/Token/Sid.R")

page.problem <- function(driver, address, client) {
  request <- request(driver)
  function(session, id) {
    structure(
      list(
        connection = connection.ready(
          driver$connection(
            method = 'GET',
            url = text.fstring(
              "%s/%s/?SID=%s&action=139&prob_id=%s", 
              address, 
              client,
              text.token(sid(session)), 
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
                text.token(
                  ejsid(session)
                )
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
