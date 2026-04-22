source("Src/Text/Text.R")
source("Src/Text/Fstring.R")
source("Src/Text/Token.R")
source("Src/Http/Driver/Driver.R")
source("Src/Http/Request/Request.R")
source("Src/Http/Connection/Presets/Ready.R")
source("Src/Http/Media/Member/Text.R")
source("Src/Http/Media/Member/Number.R")
source("Src/Http/Media/Member/Multipart.R")
source("Src/Domain/Token/Ejsid.R")
source("Src/Domain/Token/Sid.R")

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
              with("SID", member.text(text.token(token.sid(session))))$
              with("prob_id", member.text(problem))$
              with("lang_id", member.text(lang))$
              with("file", member.multipart(driver, file))$
              with("action_40", member.text("Send!")),
            jar  = jar(request)$
              with("EJSID", member.text(text.token(token.ejsid(session))))
          )
        )
      ),
      class = "page_submit"
    )
  }
}

contents.page_submit <- function(x) response(x$connection)$payload()
