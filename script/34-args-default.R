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

# Function arguments can have default values
read_weather_data <- function(omit_zurich = FALSE) {
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
    filter( !(city_code == "zurich" & omit_zurich) )
}

# Function arguments can be called by name or by position,
# optional arguments are omitted
read_weather_data(TRUE)
read_weather_data(omit_zurich = TRUE)
read_weather_data()
