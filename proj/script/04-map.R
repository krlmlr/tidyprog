### Processing all files

library(tidyverse)
library(here)

# Load dictionary from file
dict <- readxl::read_excel(here("data/cities.xlsx"))
dict

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
input_files[["berlin"]]

# Read a single input file
readxl::read_excel(here(input_files[[1]]))

# Read all input files
input_data <-
  map(input_files, ~ readxl::read_excel(here(.)))
input_data
input_data[[1]]
names(input_data)

# Pipe notation
input_files %>%
  map(~ readxl::read_excel(here(.)))
