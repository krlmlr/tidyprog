### Argument matching



# Call matching
use_names <- function(a = 1, b = 2) {
  list(a = a, b = b)
}

use_names(3, 4)
use_names(a = 3, 4)
use_names(3, a = 4)
use_names(a = 3, b = 4)

# The ellipsis is useful to enforce naming of arguments
enforce_names <- function(..., a = 1, b = 2) {
  list(a = a, b = b)
}

enforce_names(3, 4)
enforce_names(a = 3, 4)
enforce_names(a = 3, b = 4)

# Arguments in ellipsis can be captured via list()
ellipsis_test <- function(...) {
  args <- list(...)
  names(args)
}

ellipsis_test(a = 1, 2, c = 3:5)

## Exercise: call matching


## What does the following return? Why?
read_weather_data(TRUE, omit_z = FALSE) %>%
  count(city_code)

## How do you avoid this behavior?


## Ellipsis inbetween


use_some_names <- function(a = 1, ..., b = 2) {
  list(a = a, b = b)
}

use_some_names(3, 4)
use_some_names(a = 3, 4)
use_some_names(3, a = 4)
use_some_names(a = 3, b = 4)
use_some_names(b = 4, 3)

## Program defensively!

use_always_names <- function(..., a = 1, b = 2) {
  extra_args <- list(...)
  stopifnot(length(extra_args) == 0)

  list(a = a, b = b)
}

try(use_always_names(3, 4))
try(use_always_names(a = 3, 4))
try(use_always_names(3, a = 4))
try(use_always_names(b = 4, 3))
use_always_names(a = 3, b = 4)
