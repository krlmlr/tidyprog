### <No caption defined>

library(tidyverse)
library(here)

dict <- readxl::read_excel(here("data/cities.xlsx"))

dict_data <-
  dict %>%
  mutate(data = map(weather_filename, ~ readxl::read_excel(here(.)))) %>%
  select(-weather_filename)

# Flatten a nested tibble with unnest():
dict_data %>%
  unnest()

dict_data %>%
  unnest() %>%
  count(name)

# Inverse operation: nest()
dict_data %>%
  unnest() %>%
  nest(-city_code, -name, -lng, -lat)

# Split into daily data:
dict_data %>%
  unnest() %>%
  mutate(date = as.Date(time)) %>%
  nest(-date)
