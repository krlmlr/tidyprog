### Control flow

library(tidyverse)
library(here)

weather_path <- function(filename) {
  # Returned value
  here("data/weather", filename)
}
read_weather_file <- function(filename) {
  readxl::read_excel(weather_path(filename))
}

# if () executes code conditionally
read_weather_data <- function(omit_zurich = FALSE, omit_toronto = FALSE) {
  # Create ensemble dataset from files on disk
  weather_data <- bind_rows(
    berlin = read_weather_file("berlin.xlsx"),
    toronto = read_weather_file("toronto.xlsx"),
    tel_aviv = read_weather_file("tel_aviv.xlsx"),
    zurich = read_weather_file("zurich.xlsx"),
    .id = "city_code"
  )

  # Filter, conditionally
  if (omit_zurich) {
    weather_data <-
      weather_data %>%
      filter(city_code != "zurich")
  }

  if (omit_toronto) {
    weather_data <-
      weather_data %>%
      filter(city_code != "toronto")
  }

  # Return result
  weather_data
}

read_weather_data(omit_toronto = TRUE, omit_zurich = TRUE) %>%
  count(city_code)

read_weather_data(omit_toronto = TRUE, omit_zurich = FALSE) %>%
  count(city_code)

# Useful with an early return()
# && and ||: shortcut operators for scalar logical
read_weather_data <- function(omit_zurich = FALSE, omit_toronto = FALSE) {
  # Create ensemble dataset from files on disk
  weather_data <- bind_rows(
    berlin = read_weather_file("berlin.xlsx"),
    toronto = read_weather_file("toronto.xlsx"),
    tel_aviv = read_weather_file("tel_aviv.xlsx"),
    zurich = read_weather_file("zurich.xlsx"),
    .id = "city_code"
  )

  # Can keep original data?
  if (!omit_zurich && !omit_toronto) {
    return(weather_data)
  }

  # Filter, conditionally
  if (omit_zurich) {
    weather_data <-
      weather_data %>%
      filter(city_code != "zurich")
  }

  if (omit_toronto) {
    weather_data <-
      weather_data %>%
      filter(city_code != "toronto")
  }

  # Return result
  weather_data
}

# else if/else: branching
# (Just for illustration, do not implement code like this!)
read_weather_data <- function(omit_zurich = FALSE, omit_toronto = FALSE) {
  # Create ensemble dataset from files on disk
  weather_data <- bind_rows(
    berlin = read_weather_file("berlin.xlsx"),
    toronto = read_weather_file("toronto.xlsx"),
    tel_aviv = read_weather_file("tel_aviv.xlsx"),
    zurich = read_weather_file("zurich.xlsx"),
    .id = "city_code"
  )

  # Filter, conditionally, and return
  if (!omit_zurich && !omit_toronto) {
    weather_data
  } else if (omit_zurich && !omit_toronto) {
    weather_data %>%
      filter(city_code != "zurich")
  } else if (!omit_zurich && omit_toronto) {
    weather_data %>%
      filter(city_code != "toronto")
  } else {
    # Filter both
    weather_data %>%
      filter(city_code != "zurich") %>%
      filter(city_code != "toronto")
  }
}

read_weather_data(omit_toronto = TRUE) %>%
  count(city_code)
read_weather_data(omit_zurich = TRUE) %>%
  count(city_code)
