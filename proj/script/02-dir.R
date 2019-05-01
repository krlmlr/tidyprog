library(tidyverse)
library(here)

# Show all files
files <- dir(here("data/weather"), full.names = TRUE)
files

# see also fs::dir_ls()

# Convert to tibble
files_df <-
  files %>%
  enframe()

files_df

# Remove the name column
files_df_1 <-
  files %>%
  enframe(name = NULL)

files_df_1

# Construct tibble from a vector
tibble(filename = files)

# Extract a column as a vector
files_df %>%
  pull()

# Extract a specific column as a vector
files_df %>%
  pull(name)
