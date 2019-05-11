### A custom plotting function

library(tidyverse)
library(rlang)

# First attempt: create a function that plots a histogram,
# taking a variable name as input
tidy_histogram <- function(.data, x) {
  .data %>%
    ggplot(aes(x = x)) +
    geom_histogram()
}

# Would that work?
data <- tibble(a = 1:10)

try(print(
  data %>%
    tidy_histogram(a)
))

try(print(
  data %>%
    tidy_histogram("a")
))

# No, the function is looking for a variable named x,
# no matter what we pass in:
data <- tibble(a = 1:10, x = 11:20)

data %>%
  tidy_histogram(a)

# Solution: quote-unquote
tidy_histogram <- function(.data, x) {
  # Treat the argument as a variable name
  expr <- enquo(x)

  .data %>%
    # Tell ggplot2 that expr *contains* the name of the variable,
    # instead of expecting a variable named `expr`
    ggplot(aes(x = !!expr)) +
    geom_histogram()
}

data %>%
  tidy_histogram(a)

data %>%
  tidy_histogram(x)

try(print(
  data %>%
    tidy_histogram(y)
))

# This requires tidyeval support from the function that is called!
aes

### Exercises

# mutate_map_dbl() function
mutate_map_dbl <- function(.data, col, expr) {
  quo <- enquo(col)

  .data %>%
    mutate(new_column = map_dbl(!!quo, expr))
}

iris_nested <-
  iris %>%
  nest(-Species)

iris_nested %>%
  mutate_map_dbl(data, ~ mean(.$Petal.Width))
