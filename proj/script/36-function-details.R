### Default values

library(tidyverse)
library(here)
library(conflicted)

conflict_prefer("filter", "dplyr")


weather_path <- function(filename) {
  # Returned value
  here("data/weather", filename)
}
read_weather_file <- function(filename) {
  readxl::read_excel(weather_path(filename))
}

# Multiple function arguments are separated by comma:
read_weather_data <- function(omit_zurich = FALSE, omit_toronto = FALSE) {
  # Create ensemble dataset from files on disk
  weather_data <- bind_rows(
    berlin = read_weather_file("berlin.xlsx"),
    toronto = read_weather_file("toronto.xlsx"),
    tel_aviv = read_weather_file("tel_aviv.xlsx"),
    zurich = read_weather_file("zurich.xlsx"),
    .id = "city_code"
  )

  # Return it (filtered)
  weather_data %>%
    filter( !(city_code == "zurich" & omit_zurich) ) %>%
    filter( !(city_code == "toronto" & omit_toronto) )
}

# Ellipsis: variable argument list, useful for passing arguments downstream
weather_path <- function(...) {
  # All arguments are passed on
  here("data/weather", ...)
}

weather_path("berlin.xlsx")

weather_path("some", "subdir", "with", "a", "file.csv")

# Note: despite many changes and new features,
# the original call still works!
# (This can be tested automatically!)
read_weather_data()

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

use_always_names <- function(a = 1, ..., b = 2) {
  extra_args <- list(...)
  stopifnot(length(extra_args) == 0)

  list(a = a, b = b)
}

try(use_always_names(3, 4))
use_always_names(a = 3, 4)
use_always_names(3, a = 4)
use_always_names(a = 3, b = 4)
use_always_names(b = 4, 3)
