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


komoot

# Results are stored in the "content" column:
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
komoot_content %>%
  map(accessor)
