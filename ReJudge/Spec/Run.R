spec.run <- function(rscript, example) {
  text.lambda(
    function() {
      actual <- trimws(paste(
        system2(
          "Rscript", 
          args = contents(rscript), 
          input = contents(
            input(example)
          ), 
          stdout = TRUE
        ),
        collapse = "\n"
      ))
      expected <- trimws(contents(output(example)))
      if (identical(actual, expected)) actual else NA_character_
    }
  )
}
