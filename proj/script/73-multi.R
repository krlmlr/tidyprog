### Iterating and traversing

library(tidyverse)
library(here)

komoot <- readRDS(here("data/komoot.rds"))
komoot_content <-
  komoot %>%
  pull(content)

# Use multiple accessors:
accessor_coords <- list("features", 1, "geometry", "coordinates")
accessor_country <- list("features", 1, "properties", "country")

komoot_content %>%
  map(accessor_coords)

komoot_content %>%
  map(accessor_country)

# All at once:
accessors <- list(coords = accessor_coords, country = accessor_country)

accessors %>%
  map(~ map(komoot_content, .))
