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

get_weather_file_for <- function(city_code) {
  paste0(city_code, ".xlsx")
}

get_weather_data_for <- function(city_code) {
  read_weather_file(get_weather_file_for(city_code))
}

# Multiple function arguments are separated by comma:
read_weather_data <- function(omit_zurich = FALSE, omit_toronto = FALSE) {
  # Create ensemble dataset from files on disk
  weather_data <- bind_rows(
    berlin = get_weather_data_for("berlin"),
    toronto = get_weather_data_for("toronto"),
    tel_aviv = get_weather_data_for("tel_aviv"),
    zurich = get_weather_data_for("zurich"),
    .id = "city_code"
  )

  # Return it (filtered)
  weather_data %>%
    filter( !(city_code == "zurich" & omit_zurich) ) %>%
    filter( !(city_code == "toronto" & omit_toronto) )
}

# Good:
read_weather_data(omit_zurich = TRUE)
read_weather_data(omit_toronto = TRUE)

# Bad:
read_weather_data(TRUE)

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

# Exercises

# What does the following return? Why?
read_weather_data(TRUE, omit_z = FALSE) %>%
  count(city_code)
