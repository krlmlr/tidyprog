### Pure functions and side effects

library(tidyverse)

# Functions should do one thing, and do it well.

# Pure function: called for its return value, no side effects!
pure_function <- function(x) {
  x + 1
}

pure_function(1)

# Function with side effect: called for its side effect, returns input
# invisibly (=no changes to return value).
side_effect_function <- function(x) {
  file <- tempfile()
  writeLines(format(x), tempfile())
  print(x)
  message(x, " written to ", file)
  invisible(x)
}

side_effect_function(2)

# Separation helps isolate the side effects.
# If side effect functions return the input, they remain composable with
# pure functions.
5 %>%
  pure_function() %>%
  side_effect_function() %>%
  pure_function()
