### Indexing/subsetting

library(tidyverse)
library(here)

dict <- readxl::read_excel(here("data/cities.xlsx"))

# Collect input files as a named vector
input_files <-
  dict %>%
  select(city_code, weather_filename) %>%
  deframe()
input_files
names(input_files)

# Access individual input files
input_files[1]
input_files[[1]]

input_files["berlin"]
input_files[["berlin"]]

# Access multiple input files
input_files[1:2]
input_files[c("berlin", "zurich")]

# Consistent pipe-friendly access of single elements
input_files %>%
  pluck(1)
input_files %>%
  pluck("berlin")

# Exercises

input_files %>%
  enframe() %>%
  filter(name == "toronto") %>%
  deframe()
