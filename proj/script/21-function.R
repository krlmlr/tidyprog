### Definition and execution

library(tidyverse)
library(here)

# Important! Please reset the R session before running this script.
# (In RStudio: Session/Restart R)


# Declare a function to hide implementation details
read_weather_data <- function() {
  # Read all files
  berlin <- readxl::read_excel(here("data/weather", "berlin.xlsx"))
  toronto <- readxl::read_excel(here("data/weather", "toronto.xlsx"))
  tel_aviv <- readxl::read_excel(here("data/weather", "tel_aviv.xlsx"))
  zurich <- readxl::read_excel(here("data/weather", "zurich.xlsx"))

  # Create ensemble dataset
  weather_data <- bind_rows(
    berlin = berlin,
    toronto = toronto,
    tel_aviv = tel_aviv,
    zurich = zurich,
    .id = "city_code"
  )

  # Return it
  weather_data
}

# Functions are first-class objects
read_weather_data

# Execute like functions exported from packages
read_weather_data()

# Variables are local, execution doesn't change global variables.
# (The effect is only seen when starting R in a fresh session.)
ls()

# Assign result to use in further operations
weather_data <- read_weather_data()
