### Moving to tibble-land

library(tidyverse)
library(here)

dict <- readxl::read_excel(here("data/cities.xlsx"))

input_data <-
  dict %>%
  select(city_code, weather_filename) %>%
  deframe() %>%
  map(~ readxl::read_excel(here(.)))

# Lists are also vectors, enframe() returns a nested tibble!
nested_input_data <-
  input_data %>%
  enframe()

nested_input_data

# Operate in "tibble-land" right away: columns are vectors
dict %>%
  select(city_code, weather_filename) %>%
  mutate(
    data = map(weather_filename, ~ readxl::read_excel(here(.)))
  )

# Create an intermediate column to simplify the map() call:
dict %>%
  select(city_code, weather_filename) %>%
  mutate(path = here(weather_filename)) %>%
  mutate(data = map(path, readxl::read_excel))

# Keep important columns
dict_data <-
  dict %>%
  mutate(
    data = map(weather_filename, ~ readxl::read_excel(here(.))),
    rows = map_int(data, nrow),
  ) %>%
  select(-weather_filename)
dict_data

# Also with map2:
dict_data_with_desc <-
  dict_data %>%
  mutate(
    desc = map2_chr(
      name, rows,
      ~ paste0(..2, " rows in data for ", ..1)
    )
  )

# Access the most recently added column with pull():
dict_data_with_desc %>%
  pull()

# More than two arguments:
dict_data %>%
  mutate(
    cols = map_int(data, ncol),
    desc = pmap_chr(
      list(name, rows, cols),
      ~ paste0(..2, " rows and ", ..3, " cols in data for ", ..1)
    )
  )

# A nicer interface?
map_mutate <- function(.data, col, expr) {
  col <- rlang::enexpr(col)

  .data %>%
    mutate(data = map(!!col, expr))
}

dict %>%
  map_mutate(weather_filename, ~ readxl::read_excel(here(.)))

# Process a tibble rowwise: an alternative
processor <- function(row) {
  row %>%
    mutate(cells = prod(dim(data[[1]])))
}

dict_data %>%
  rowid_to_column() %>%
  nest(-rowid) %>%
  pull() %>%
  map(processor) %>%
  bind_rows()

# Exercises

input_data %>%
  imap_chr(~ paste0(.y, ": ", nrow(.x), " rows"))
