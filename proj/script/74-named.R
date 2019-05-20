### Names

library(tidyverse)
library(rlang)

# Combo: unnamed arguments define grouping, named arguments define summary
gsu <- function(.data, ...) {
  # Capture (quote) with enquos()
  quos <- enquos(...)

  is_named <- (names2(quos) != "")
  named_quos <- quos[is_named]
  unnamed_quos <- quos[!is_named]

  # Use (unquote-splice) with !!!
  .data %>%
    group_by(!!!unnamed_quos) %>%
    summarize(!!!named_quos) %>%
    ungroup()
}

# Test it:
mean_airtime_per_day <-
  nycflights13::flights %>%
  gsu(year, month, day, mean_air_time = mean(air_time, na.rm = TRUE))

mean_airtime_per_day
