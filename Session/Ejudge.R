source("Session/Session.R")
source("Text/Fstring.R")
source("Http/Driver/Driver.R")
source("Http/Request/Request.R")
source("Http/Media/Member/Text.R")
source("Http/Connection/Presets/Ready.R")

session.ejudge = function(driver, address, client) {
  request <- request(driver)
  function(login, pass, contest) {
    structure(
      list(
        connection = connection.ready(
          driver$connection(
            method  = 'POST',
            url     = text.fstring("%s/%s", address, client),
            headers = headers(request)$
              with('Accept', member.text(paste0(
                'text/html,application/xhtml+xml,application/xml;q=0.9,',
                'image/avif,image/webp,image/apng,*/*;q=0.8,',
                'application/signed-exchange;v=b3;q=0.7'
                ))
              )$
              with('Content-Type', member.text('application/x-www-form-urlencoded')),
            body    = body(request)$
              with('contest_id', member.text(contest))$
              with('login', member.text(login))$
              with('password', member.text(pass))$
              with('action_2', member.text('Log in')),
            encode  = 'form'
          )
        )
      ),
      class = "ejudge_session"
    )
  }
}

html.ejudge_session    <- function(x) response(x$connection)$html()
cookies.ejudge_session <- function(x) response(x$connection)$cookies()
