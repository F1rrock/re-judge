source("ReJudge/Dom/Engine/Engine.R")

problem.language <- function(engine) {
  dom <- dom(engine)
  function(page) {
    dom$attr(
      "value",
      dom$selection(
        "input[name='lang_id']",
        dom$selection(
          "table.b0",
          dom$selection(
            "form",
            dom$selection(
              "div#ej-submit-tabs",
              dom$root(page)
            )
          )
        )
      )
    )
  }
}
