### Flattening

library(tidyverse)
library(here)

komoot <- readRDS(here("data/komoot.rds"))

komoot_content <-
  komoot %>%
  pull(content)

coordinates <-
  komoot_content %>%
  map(list("features", 1, "geometry", "coordinates"))

# Odd structure:
coordinates %>%
  pluck(1)

# Flattening can chop off a layer, need to specify output type:
coordinates %>%
  pluck(1) %>%
  flatten_dbl()

# Apply to entire list:
coordinates %>%
  map(~ flatten_dbl(.))
