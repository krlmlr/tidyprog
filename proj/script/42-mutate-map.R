### Moving to tibble-land

library(tidyverse)
library(here)

dict <- readxl::read_excel(here("data/cities.xlsx"))

input_data <-
  dict %>%
  select(city_code, weather_filename) %>%
  deframe() %>%
  map(~ readxl::read_excel(here(.)))

# Lists are also vectors, enframe() returns a nested tibble!
input_data %>%
  enframe()

# Operate in "tibble-land" right away: columns are vectors
dict %>%
  select(city_code, weather_filename) %>%
  mutate(
    data = map(weather_filename, ~ readxl::read_excel(here(.)))
  )

# Keep important columns
dict_data <-
  dict %>%
  mutate(
    data = map(weather_filename, ~ readxl::read_excel(here(.)))
  ) %>%
  select(-weather_filename)
dict_data
