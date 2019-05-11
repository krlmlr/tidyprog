### Processing multiple files

library(tidyverse)
library(here)

dict <- readxl::read_excel(here("data/cities.xlsx"))

input_files <-
  dict %>%
  select(city_code, weather_filename) %>%
  deframe()

# Read a single input file
input_files[[1]]
here(input_files[[1]])
readxl::read_excel(here(input_files[[1]]))

# Try reading all input files
here(input_files)
try(readxl::read_excel(here(input_files)))

# Read all input files
input_data <-
  map(input_files, ~ readxl::read_excel(here(.)))

# Equivalent code
input_data <-
  list(
    berlin = readxl::read_excel(here(input_files[[1]])),
    toronto = readxl::read_excel(here(input_files[[2]])),
    tel_aviv = readxl::read_excel(here(input_files[[3]])),
    zurich = readxl::read_excel(here(input_files[[4]]))
  )

# Analyze the results
input_data
input_data[[1]]
names(input_data)

# Pipe notation
input_files %>%
  map(~ readxl::read_excel(here(.)))

# Exercises

input_files[c("toronto", "tel_aviv")] %>%
  map(~ readxl::read_excel(here(.)))

input_files %>%
  enframe() %>%
  filter(name %in% c("toronto", "tel_aviv")) %>%
  deframe() %>%
  map(~ readxl::read_excel(here(.)))

input_files %>%
  enframe() %>%
  mutate(value = here(value)) %>%
  deframe() %>%
  map(~ readxl::read_excel(.))
