source("Text/Text.R")
source("Text/Fstring.R")
source("Text/Token.R")
source("Http/Driver/Driver.R")
source("Http/Request/Request.R")
source("Http/Connection/Presets/Ready.R")
source("Http/Media/Member/Text.R")
source("Http/Media/Member/Multipart.R")
source("Domain/Token/Ejsid.R")
source("Domain/Token/Sid.R")

page.submit <- function(driver, address, client) {
  request <- request(driver)
  function(session, lang, problem, file) {
    structure(
      list(
        connection = connection.ready(
          driver$connection(
            method = "POST",
            url  = text.fstring("%s/%s/", address, client),
            body = body(request)$
              with("SID", member.text(text.token(sid(session))))$
              with("prob_id", member.text(problem))$
              with("lang_id", member.text(lang))$
              with("file", member.multipart(driver, file))$
              with("action_40", member.text("Send!")),
            jar  = jar(request)$
              with("EJSID", member.text(text.token(ejsid(session))))
          )
        )
      ),
      class = "page_submit"
    )
  }
}

contents.page_submit <- function(x) response(x$connection)$html()
