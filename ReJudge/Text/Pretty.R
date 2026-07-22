text.pretty <- function(origin) {
  text.lambda(
    function() {
      paste(
        styler::style_text(
          text = contents(origin)
        ),
        collapse = "\n"
      )
    }
  )
}
