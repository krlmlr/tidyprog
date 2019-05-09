### Multiple arguments

library(tidyverse)
library(here)


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

## What does the following return? Why?
read_weather_data(TRUE, omit_z = FALSE) %>%
  count(city_code)
