### Processing multiple files

library(tidyverse)
library(here)

dict <- readxl::read_excel(here("data/cities.xlsx"))

input_files <-
  dict %>%
  select(city_code, weather_filename) %>%
  deframe()

# Read a single input file
readxl::read_excel(here(input_files[[1]]))

# Read all input files
input_data <-
  map(input_files, ~ readxl::read_excel(here(.)))

# Analyze the results
input_data
input_data[[1]]
names(input_data)

# Pipe notation
input_files %>%
  map(~ readxl::read_excel(here(.)))

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
