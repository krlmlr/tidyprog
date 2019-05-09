### Manipulating all datasets

library(tidyverse)
library(here)

dict <- readxl::read_excel(here("data/cities.xlsx"))

input_data <-
  dict %>%
  select(city_code, weather_filename) %>%
  deframe() %>%
  map(~ readxl::read_excel(here(.)))

# Manipulate results
input_data %>%
  map(~ select(., time, contains("emperature")))

# Manipulate results more
input_data %>%
  map(~ select(., time, contains("emperature"))) %>%
  map(~ filter(., temperature >= 14))

# Create a function to manipulate
manipulator <- function(data) {
  data %>%
    select(time, contains("emperature")) %>%
    filter(temperature >= 14)
}

# Functions are first-class objects!
manipulator

# Test the function
manipulator(input_data[[4]])

# Run the function on the entire dataset
manipulated_data <- map(input_data, ~ manipulator(.))
manipulated_data

# Shortcut
map(input_data, manipulator)
