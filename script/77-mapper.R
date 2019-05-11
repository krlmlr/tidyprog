library(tidyverse)
library(rlang)

mutate_map_dbl <- function(.data, col, ...) {
  quos <- build_quos(!!enquo(col), ...)
  .data %>%
    mutate(!!!quos)
}

# Refining build_quos() to get rid of the tilde:
build_quos <- function(col, ...) {
  args <- enquos(...)
  stopifnot(length(args) == 1)

  expr <- args[[1]]

  map_quo <- build_map_quo(!!enquo(col), !!expr)

  set_names(list(map_quo), names(args))
}

build_map_quo <- function(col, expr) {
  quo <- enquo(col)
  mapper <- as_mapper_quosure(!!enquo(expr))
  quo(map_dbl(!!quo, !!mapper))
}

as_mapper_quosure <- function(expr) {
  quo <- enquo(expr)

  rlang::new_function(alist(... = , . = ..1, .x = ..1, .y = ..2), quo_get_expr(quo))
}

# Test it:
as_mapper(~ mean(.$Petal.Width))

as_mapper_quosure(mean(.$Petal.Width))

build_map_quo(mean_petal_width, mean(.$Petal.Width))

# Run it:
iris %>%
  nest(-Species) %>%
  mutate_map_dbl(data, mean_petal_width = mean(.$Petal.Width))
