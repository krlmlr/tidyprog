### Closures

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

# Create a function that loads a particular dataset
make_read_weather_file <- function(filename) {
  # Avoid odd effects due to lazy evaluation
  force(filename)

  # This function (closure) accesses the filename from the
  # outer function
  f <- function() {
    read_weather_file(filename)
  }

  f
}

read_berlin <- make_read_weather_file("berlin.xlsx")
read_toronto <- make_read_weather_file("toronto.xlsx")
read_tel_aviv <- make_read_weather_file("tel_aviv.xlsx")
read_zurich <- make_read_weather_file("zurich.xlsx")

read_berlin
read_toronto

read_berlin()
read_toronto()

# Use case: adverbs -- wrappers for other verbs
loudly <- function(f) {
  force(f)

  function(...) {
    args <- list(...)
    msg <- paste0(length(args), " argument(s)")
    message(msg)

    f(...)
  }
}

read_loudly <- loudly(read_weather_file)
read_loudly
read_loudly("berlin.xlsx")

# safely()
cities <- list("berlin", "toronto", "milan", "tel_aviv")
try(map(cities, get_weather_data_for))
map(cities, safely(get_weather_data_for))
safely(get_weather_data_for)

map(cities, ~ safely(get_weather_data_for)(.))

safe_get_weather_data_for <- safely(get_weather_data_for)
map(cities, ~ safe_get_weather_data_for(.))
