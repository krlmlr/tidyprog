### Typed output

library(tidyverse)
library(here)

dict <- readxl::read_excel(here("data/cities.xlsx"))

input_data <-
  dict %>%
  select(city_code, weather_filename) %>%
  deframe() %>%
  map(~ readxl::read_excel(here(.)))

# map() returns a list
input_data %>%
  map(~ nrow(.))

# Return an integer vector with map_int()
input_data %>%
  map_int(~ nrow(.))

# ... or a character vector?
input_data %>%
  map_chr(~ nrow(.))

input_data %>%
  map_chr(~ as.character(nrow(.)))

# Exercises

# map_dbl()
input_data %>%
  map(dim)

try(
  input_data %>%
    map_dbl(dim)
)

input_data %>%
  map_dbl(~ dim(.)[[2]])

# Concise
input_data %>%
  map(~ slice(., 1)) %>%
  map_dbl(~ pull(., temperature))

summarize_weather <- function(data) {
  data %>%
    summarize(
      max_temp = max(temperature),
      min_temp = min(temperature),
      mean_humidity = mean(humidity),
      summary = paste(rle(summary)$values, collapse = ", then ")
    )
}

describe_weather <- function(weather_summary) {
  weather_summary %>%
    mutate(
      text = paste0(
        "We had temperatures between ", min_temp, " and ", max_temp, " °C. ",
        "The average humidity was ", round(mean_humidity * 100), " %. ",
        "The weather was ", summary, "."
      )
    ) %>%
    pull()
}

input_data %>%
  map(summarize_weather) %>%
  map_chr(describe_weather) %>%
  enframe()
