### Named vectors and two-column tibbles

library(tidyverse)
library(here)

# Load dictionary from file
dict <- readxl::read_excel(here("data/cities.xlsx"))
dict

# Acquire file names
dict %>%
  pull(weather_filename)

# Use here() to create absolute paths
dict %>%
  pull(weather_filename) %>%
  here()

# Acquire file names as a named vector
weather_filenames <-
  dict %>%
  select(city_code, weather_filename) %>%
  deframe()
weather_filenames

# Use names() to access names
weather_filenames %>%
  names()

# Not all operations maintain vector names!
weather_filenames %>%
  here()

# Move the here() call into "tibble-land"
dict %>%
  mutate(weather_filename_here = here(weather_filename)) %>%
  select(city_code, weather_filename_here) %>%
  deframe()
