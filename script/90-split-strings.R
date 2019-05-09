### <No caption defined>



library(tidyverse)
library(here)

dict <- readxl::read_excel(here("data/cities.xlsx"))

# strsplit() or stringr functions
dict %>%
  pull(name) %>%
  strsplit(" ")

# Back to tibble-land
dict %>%
  mutate(split = strsplit(name, " "))

# Same result with map()?
dict %>%
  mutate(split = map(name, ~ strsplit(., " ")))

# Need flatten:
dict %>%
  mutate(split = flatten(map(name, ~ strsplit(., " "))))

# Unnesting works, but brittle:
dict %>%
  mutate(split = strsplit(name, " ")) %>%
  select(city_code, split) %>%
  unnest()

# Create a nested data frame first
dict %>%
  mutate(split = strsplit(name, " ")) %>%
  mutate(data = map(split, enframe)) %>%
  select(city_code, data) %>%
  unnest()
