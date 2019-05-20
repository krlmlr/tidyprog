### Arguments

library(tidyverse)
library(here)

# Functions can have arguments
weather_path <- function(filename) {
  # Returned value
  here("data/weather", filename)
}

weather_path("milan.xlsx")

# Functions can be called by other functions
read_weather_data <- function() {
  # Read all files
  berlin <- readxl::read_excel(weather_path("berlin.xlsx"))
  toronto <- readxl::read_excel(weather_path("toronto.xlsx"))
  tel_aviv <- readxl::read_excel(weather_path("tel_aviv.xlsx"))
  zurich <- readxl::read_excel(weather_path("zurich.xlsx"))

  # Create ensemble dataset
  weather_data <- bind_rows(
    berlin = berlin,
    toronto = toronto,
    tel_aviv = tel_aviv,
    zurich = zurich,
    .id = "city_code"
  )

  # Return it
  weather_data
}

# Still need to run a function
read_weather_data()

# Exercises
