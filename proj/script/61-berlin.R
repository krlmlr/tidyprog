### Traversing

library(tidyverse)
library(here)

# Results from downloading geolocation data from photon.komoot.de:
berlin <- readRDS(here("data/komoot-berlin.rds"))

berlin
str(berlin)

# Access components
berlin$type
berlin$features
berlin$features[[1]]

# Uniform access with pluck():
berlin %>%
  pluck("type")
berlin[["type"]]

berlin %>%
  pluck("features")

berlin %>%
  pluck("features", 1)
berlin[["features"]][[1]]

berlin %>%
  pluck("features", 1, "geometry")
berlin[["features"]][[1]][["geometry"]]

berlin %>%
  pluck("features", 1, "geometry", "coordinates")

# Accessing different properties
berlin %>%
  pluck("features", 1, "properties", "country")

# Composable
berlin %>%
  pluck("features", 1) %>%
  pluck("properties", "country")
