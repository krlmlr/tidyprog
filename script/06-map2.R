### Manipulating pairwise

library(tidyverse)
library(here)

# Load dictionary from file
dict <- readxl::read_excel(here("data/cities.xlsx"))
dict

# Create a function to manipulate
manipulator <- function(data) {
  data %>%
    select(time, contains("emperature")) %>%
    filter(temperature >= 14)
}

# Collect and manipulate input data
manipulated_data <-
  dict %>%
  select(city_code, weather_filename) %>%
  deframe() %>%
  map(~ readxl::read_excel(here(.))) %>%
  map(manipulator)

# Write back results: new file names
output_filenames <- tempfile(names(manipulated_data), fileext = ".csv")
output_filenames

# Iterate over pairs
map2(manipulated_data, output_filenames, ~ readr::write_csv(..1, ..2))

# We don't really need the output
walk2(manipulated_data, output_filenames, ~ readr::write_csv(..1, ..2))
