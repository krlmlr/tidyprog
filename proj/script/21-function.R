### Definition and execution

library(tidyverse)
library(here)

# Important! Please reset the R session before running this script.
# (In RStudio: Session/Restart R)


# Declare a function to hide implementation details
read_weather_data <- function() {
  # Read all files
  berlin <- readxl::read_excel(here("data/weather", "berlin.xlsx"))
  toronto <- readxl::read_excel(here("data/weather", "toronto.xlsx"))
  tel_aviv <- readxl::read_excel(here("data/weather", "tel_aviv.xlsx"))
  zurich <- readxl::read_excel(here("data/weather", "zurich.xlsx"))

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

# Functions are first-class objects
read_weather_data

# Call like functions exported from packages
read_weather_data()

# Variables are local, execution doesn't change global variables.
# (The effect is only seen when starting R in a fresh session.)
ls()

# Pipe
read_weather_data() %>%
  count(city_code)

# Assign result to use in further operations
weather_data <- read_weather_data()

# Exercises

read_weather_data_non_europe <- function() {
  # Read non-Europe files
  toronto <- readxl::read_excel(here("data/weather", "toronto.xlsx"))
  tel_aviv <- readxl::read_excel(here("data/weather", "tel_aviv.xlsx"))

  # Create ensemble dataset
  weather_data_non_europe <- bind_rows(
    toronto = toronto,
    tel_aviv = tel_aviv,
    .id = "city_code"
  )

  # Return it
  weather_data_non_europe
}

read_weather_data_non_europe()

# Double-check:
nrow(read_weather_data()) - nrow(read_weather_data_non_europe())
