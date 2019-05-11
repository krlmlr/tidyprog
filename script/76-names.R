library(tidyverse)
library(rlang)

# A mutate_map() variant that allows naming the output column:
mutate_map_dbl <- function(.data, col, ...) {
  quos <- build_quos(!!enquo(col), ...)
  .data %>%
    mutate(!!!quos)
}

build_quos <- function(col, ...) {
  args <- list(...)
  stopifnot(length(args) == 1)

  expr <- args[[1]]

  map_quo <- build_map_quo(!!enquo(col), expr)

  set_names(list(map_quo), names(args))
}

build_map_quo <- function(col, expr) {
  quo <- enquo(col)
  quo(map_dbl(!!quo, expr))
}

# Test it:
build_quos(data, mean_petal_width = ~ mean(.$Petal.Width))

build_map_quo(mean_petal_width, ~ mean(.$Petal.Width))

# Run it:
iris %>%
  nest(-Species) %>%
  mutate_map_dbl(data, mean_petal_width = ~ mean(.$Petal.Width))
