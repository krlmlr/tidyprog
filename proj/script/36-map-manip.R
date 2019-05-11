### Manipulating all datasets

library(tidyverse)
library(here)

dict <- readxl::read_excel(here("data/cities.xlsx"))

input_data <-
  dict %>%
  select(city_code, weather_filename) %>%
  deframe() %>%
  map(~ readxl::read_excel(here(.)))

# Manipulate first result
input_data[[1]] %>%
  select(time, contains("emperature"))

# Manipulate results
input_data %>%
  map(~ select(., time, contains("emperature")))

# Manipulate results more
input_data %>%
  map(~ select(., time, contains("emperature"))) %>%
  map(~ filter(., temperature >= 14))

# Create a function to manipulate
find_good_times <- function(data) {
  data %>%
    select(time, contains("emperature")) %>%
    filter(temperature >= 14)
}

# Functions are first-class objects!
find_good_times

# Test the function
find_good_times(input_data[[4]])

# Run the function on the entire dataset
good_times <- map(input_data, ~ find_good_times(.))
good_times

# Shortcut
map(input_data, find_good_times)

# Exercises

input_data %>%
  map(~ summarize(., mean(temperature), mean(humidity)))

compute_daily_mean <- function(data) {
  data %>%
    group_by(as.Date(time)) %>%
    summarize(mean(temperature), mean(humidity)) %>%
    ungroup()
}
input_data %>%
  map(compute_daily_mean)

input_data %>%
  map(dim)
input_data %>%
  map(dim) %>%
  map(prod)

create_plot <- function(data) {
  data %>%
    ggplot(aes(x = pressure, y = humidity, color = temperature)) +
    geom_path()
}

plots <-
  input_data %>%
  map(create_plot)

plots
