### Transposing

library(tidyverse)
library(here)

komoot <- readRDS(here("data/komoot.rds"))

komoot_content <-
  komoot %>%
  pull(content)

coordinates <-
  komoot_content %>%
  map(list("features", 1, "geometry", "coordinates"))

# Transposing inside out:
coordinates %>%
  transpose()

# Flatten to simplify structure:
coordinates_transposed <-
  coordinates %>%
  transpose() %>%
  map(~ flatten_dbl(.))
coordinates_transposed
