library(tidyverse)
library(here)

# Load dictionary from file
dict <- readxl::read_excel(here("data/cities.xlsx"))
dict

# map() on a vector
input_data <-
  dict %>%
  select(city_code, weather_filename) %>%
  deframe() %>%
  map(~ readxl::read_excel(here(.)))

input_data

# Lists are also vectors, enframe() returns a nested tibble!
input_data %>%
  enframe()

# Operate in "tibble-land": columns are vectors
dict %>%
  select(city_code, weather_filename) %>%
  mutate(
    data = map(weather_filename, ~ readxl::read_excel(here(.)))
  )

# Keep auxiliary columns
dict %>%
  mutate(
    data = map(weather_filename, ~ readxl::read_excel(here(.)))
  ) %>%
  select(city_code, name, data)
