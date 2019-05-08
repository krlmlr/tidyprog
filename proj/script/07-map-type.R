### Typed output

library(tidyverse)
library(here)

dict <- readxl::read_excel(here("data/cities.xlsx"))

input_data <-
  dict %>%
  select(city_code, weather_filename) %>%
  deframe() %>%
  map(~ readxl::read_excel(here(.)))

# map() returns a list
input_data %>%
  map(~ nrow(.))

# Return an integer vector with map_int()
input_data %>%
  map_int(~ nrow(.))

# ... or a character vector?
input_data %>%
  map_chr(~ as.character(nrow(.)))
