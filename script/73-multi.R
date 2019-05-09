### Iterating and traversing

library(tidyverse)
library(here)

# Results from downloading geolocation data for all cities from photon.komoot.de:
komoot <- readRDS(here("data/komoot.rds"))

komoot

# Use multiple accessors:
accessor_coords <- list("features", 1, "geometry", "coordinates")
accessor_country <- list("features", 1, "properties", "country")

komoot_content %>%
  map(accessor_coords)

komoot_content %>%
  map(accessor_country)

# All at once:
accessors <- list(accessor_coords, accessor_country)

accessors %>%
  map(~ map(komoot_content, .))

komoot_content %>%
  map(accessors)

coordinates


komoot_content <-
  komoot %>%
  pull(content)

berlin <-
  komoot_content %>%
  pluck(1)

berlin %>%
  pluck("features", 1, "geometry", "coordinates")

toronto <-
  komoot_content %>%
  pluck(2)

toronto %>%
  pluck("features", 1, "geometry", "coordinates")

# Apply same pluck() on all values with map():
komoot_content %>%
  map(~ pluck(., "features", 1, "geometry", "coordinates"))

# Shortcut:
komoot_content %>%
  map(list("features", 1, "geometry", "coordinates"))

accessor <- list("features", 1, "geometry", "coordinates")
coordinates <-
  komoot_content %>%
  map(accessor)
coordinates
