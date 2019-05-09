### Use case: Intermediate variables

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

# Exercises

# Operate on city codes, not file names:
get_weather_file_for <- function(city_code) {
  paste0(city_code, ".xlsx")
}

get_weather_file_for("munich")
get_weather_file_for("san_diego")

# High-level reader:
get_weather_data_for <- function(city_code) {
  read_weather_file(get_weather_file_for(city_code))
}

get_weather_data_for("toronto")
