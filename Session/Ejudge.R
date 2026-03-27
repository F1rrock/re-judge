source("Session/Session.R")
source("Text/Fstring.R")
source("Transport/Driver/Driver.R")
source("Transport/Connection/Presets/Ready.R")

session.ejudge = function(driver, address) {
  function(login, pass, contest) {
    structure(
      list(
        connection = connection.ready(
          driver$connection(
            method  = 'POST',
            url     = text.fstring("%s/ejudge", address),
            headers = headers(driver)$
              with('Accept', paste0(
                'text/html,application/xhtml+xml,application/xml;q=0.9,',
                'image/avif,image/webp,image/apng,*/*;q=0.8,',
                'application/signed-exchange;v=b3;q=0.7'
                )
              )$
              with('Content-Type', 'application/x-www-form-urlencoded'),
            body    = body(driver)$
              with('contest_id', contest)$
              with('login', login)$
              with('password', pass)$
              with('action_2', 'Log in'),
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
