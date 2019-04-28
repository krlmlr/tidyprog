library(tidyverse)
library(here)

# Read all files
berlin <- readxl::read_excel(here("data/weather/berlin.xlsx"))
toronto <- readxl::read_excel(here("data/weather/toronto.xlsx"))
tel_aviv <- readxl::read_excel(here("data/weather/tel_aviv.xlsx"))
zurich <- readxl::read_excel(here("data/weather/zurich.xlsx"))

# Create ensemble dataset
weather_data <- bind_rows(
  berlin = berlin,
  toronto = toronto,
  tel_aviv = tel_aviv,
  zurich = zurich,
  .id = "city_code"
)

# Visibility vs. humitidy
weather_data %>%
  ggplot(aes(x = pressure, y = humidity, color = city_code)) +
  geom_path()

# Summary
weather_data %>%
  ggplot(aes(x = city_code)) +
  geom_bar(aes(fill = summary))

weather_data %>%
  ggplot(aes(x = city_code)) +
  geom_bar(aes(fill = summary), position = position_dodge2("dodge", preserve = "single"))

# Temperature and apparent temperature
temperature_data <-
  weather_data %>%
  select(city_code, time, temperature, apparentTemperature) %>%
  gather(kind, temperature, -city_code, -time) %>%
  mutate(apparent = (kind == "apparentTemperature")) %>%
  select(-kind)

temperature_data %>%
  ggplot(aes(x = time, color = city_code)) +
  geom_linerange(data = weather_data, aes(ymin = temperature, ymax = apparentTemperature)) +
  geom_line(aes(linetype = apparent, y = temperature))

# Compute and plot temperature difference
weather_data %>%
  mutate(apparentTemperatureReduction = temperature - apparentTemperature) %>%
  filter(city_code != "tel_aviv") %>%
  ggplot(aes(x = windSpeed, y = apparentTemperatureReduction)) +
  geom_point(aes(color = city_code))

# Compute lag for temperature, pressure and humidity
weather_data %>%
  group_by(city_code) %>%
  mutate_at(vars(temperature, pressure, humidity), list(lag = lag)) %>%
  ungroup()

# How to compute temperature difference to previous hour?

# Count observations
weather_data %>%
  count(city_code)

weather_data %>%
  count(city_code, summary)

# Compute mean and max temperature
weather_data %>%
  group_by(city_code) %>%
  summarize(temperature_mean = mean(temperature), temperature_max = max(temperature)) %>%
  ungroup()

# Compute and display summary data for all numeric variables
weather_data %>%
  group_by(city_code) %>%
  summarize_if(is.numeric, list(mean = mean, sd = sd, min = min, max = max)) %>%
  ungroup() %>%
  gather(key, value, -city_code) %>%
  separate(key, into = c("indicator", "fun")) %>%
  xtabs(value ~ city_code + indicator + fun, .) %>%
  ftable()
