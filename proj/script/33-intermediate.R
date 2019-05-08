### Intermediate variables

library(tidyverse)
library(here)

weather_path <- function(filename) {
  # Returned value
  here("data/weather", filename)
}

# Functions can help eliminate intermediate variables
read_weather_file <- function(filename) {
  readxl::read_excel(weather_path(filename))
}

read_weather_data <- function() {
  # Create ensemble dataset from files on disk
  weather_data <- bind_rows(
    berlin = read_weather_file("berlin.xlsx"),
    toronto = read_weather_file("toronto.xlsx"),
    tel_aviv = read_weather_file("tel_aviv.xlsx"),
    zurich = read_weather_file("zurich.xlsx"),
    .id = "city_code"
  )

  # Return it
  weather_data
}

read_weather_data()

### Exercise


# Simplify more?


# Get rid of repeated .xlsx?

get_weather_for <- function(city) {
  filename <- paste0(city, ".xlsx")

  readxl::read_excel(
    paste0(
      weather_path(filename)
    )
  )
}

weather_path_for <- function(city) {

  here("data/weather", paste0(city, ".xlsx"))
}

get_weather_for2 <- function(city) {
  readxl::read_excel(weather_path_for(city))
}

read_weather_data <- function() {
  # Create ensemble dataset from files on disk
  weather_data <- bind_rows(
    berlin = get_weather_for2("berlin"),
    toronto = get_weather_for2("toronto"),
    tel_aviv = get_weather_for2("tel_aviv"),
    zurich = get_weather_for2("zurich"),
    .id = "city_code"
  )

  # Return it
  weather_data
}

read_weather_data()
