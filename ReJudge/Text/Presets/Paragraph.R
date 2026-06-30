source("ReJudge/Text/Default.R")
source("ReJudge/Text/Bind.R")
source("ReJudge/Text/NonEmpty.R")
source("ReJudge/Text/Fstring.R")

text.paragraph <- function(text) {
  text.default(
    fallback = "",
    text.bind(
      text.nonempty(text),
      function(x) text.fstring("%s\n", x)
    )
  )
}
