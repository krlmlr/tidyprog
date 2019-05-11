### Explicit quote-unquote of ellipsis

library(tidyverse)
library(rlang)

# Explicit capturing with enquos():
summarize_ungroup <- function(.data, ...) {
  # Capture (quote) with enquos()
  quos <- enquos(...)

  # Use (unquote-splice) with !!!
  .data %>%
    summarize(!!!quos) %>%
    ungroup()
}

# Test it:
mean_airtime_per_day <-
  nycflights13::flights %>%
  group_by(year, month, day) %>%
  summarize_ungroup(mean(air_time, na.rm = TRUE))

mean_airtime_per_day

mean_airtime_per_day %>%
  groups()

# aes() does the same:
# (summarize() did not at the time of writing: https://github.com/tidyverse/dplyr/pull/4357)
aes
