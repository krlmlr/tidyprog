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
paste0("'", weather_filenames, "'")
weather_filenames %>%
  here()

# Move the here() call into "tibble-land"
dict %>%
  mutate(weather_filename_here = here(weather_filename))

dict %>%
  mutate(weather_filename_here = here(weather_filename)) %>%
  select(city_code, weather_filename_here)

dict %>%
  mutate(weather_filename_here = here(weather_filename)) %>%
  select(city_code, weather_filename_here) %>%
  deframe()

# Exercises

dict %>%
  select(city_code, name) %>%
  deframe()

fs::dir_info()
fs::dir_info() %>%
  pull(path)

fs::dir_info() %>%
  select(name = path) %>%
  mutate(value = name) %>%
  deframe()

fs::dir_info() %>%
  select(name = path) %>%
  mutate(value = name) %>%
  deframe() %>%
  enframe()
