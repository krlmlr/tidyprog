### Basics

## TODO: Split script, don't overwrite!

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

# Execute like functions exported from packages
read_weather_data()

# Variables are local, execution doesn't change global variables.
# (The effect is only seen when starting R in a fresh session.)
ls()

# Assign result to use in further operations
weather_data <- read_weather_data()

# Functions can have arguments
weather_path <- function(filename) {
  # Returned value
  here("data/weather", filename)
}

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
