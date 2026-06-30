source("ReJugde/Text/Lambda.R")
source("ReJugde/Text/Default.R")
source("ReJugde/Text/Bind.R")
source("ReJugde/Text/NonEmpty.R")
source("ReJugde/Text/Fstring.R")

text.paragraph <- text.lambda(
  function(text) {
    text.default(
      fallback = "",
      text.bind(
        text.nonempty(text),
        function(x) text.fstring("%s\n", x)
      )
    )
  }
)
