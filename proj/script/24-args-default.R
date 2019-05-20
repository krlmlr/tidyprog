### Default values

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

# Function arguments can have default values
read_weather_data <- function(omit_zurich = FALSE) {
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
    filter( !(city_code == "zurich" & omit_zurich) )
}

# Function arguments can be called by name or by position,
# optional arguments are omitted
read_weather_data(TRUE)
read_weather_data(omit_zurich = TRUE)
read_weather_data()

# Exercises

# Default city:
get_weather_data_for <- function(city_code = "zurich") {
  read_weather_file(get_weather_file_for(city_code))
}

# Test:

get_weather_data_for() %>%
  select(temperature)
get_weather_data_for("tel_aviv") %>%
  select(temperature)
