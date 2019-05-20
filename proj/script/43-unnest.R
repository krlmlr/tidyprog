### Nesting and unnesting

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

# What happens with data of different shape?
dict_data %>%
  pull(data) %>%
  bind_rows()

check_columns_same <- function(x, y) {
  stopifnot(identical(colnames(x), colnames(y)))
}

bind_rows <- function(data_frames) {
  # Called for the side effect
  reduce(data_frames, check_columns_same)

  dplyr::bind_rows(data_frames)
}

try(
  dict_data %>%
    pull(data) %>%
    bind_rows()
)

# Mapping in nested view are grouped operation in the flat view:
dict_data %>%
  mutate(n = map_int(data, nrow)) %>%
  select(-data)

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

# Exercises

iris %>%
  group_by(Species) %>%
  summarize_all(list(Mean = mean)) %>%
  ungroup()

dict_data %>%
  as.list() %>%
  enframe()
