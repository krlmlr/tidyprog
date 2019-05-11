### Do yo need tidy evaluation?

library(tidyverse)

# Implement a version of summarize() that ungroups:
summarize_ungroup <- function(.data, ...) {
  .data %>%
    summarize(...) %>%
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
