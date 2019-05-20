### Rectangling

library(tidyverse)
library(here)

komoot <- readRDS(here("data/komoot.rds"))

komoot_content <-
  komoot %>%
  pull(content)

coordinates_transposed <-
  komoot_content %>%
  map(list("features", 1, "geometry", "coordinates")) %>%
  transpose() %>%
  map(~ flatten_dbl(.))

# A tibble is internally a list of named vectors of equal length:
coordinates_transposed %>%
  rlang::set_names(c("lon", "lat"))

coordinates_transposed %>%
  rlang::set_names(c("lon", "lat")) %>%
  as_tibble()

# Name repair helps if you don't know the names yet
coordinates_transposed %>%
  as_tibble(.name_repair = "universal")

coordinates_transposed %>%
  as_tibble(.name_repair = "universal") %>%
  rename(lon = ...1, lat = ...2)
