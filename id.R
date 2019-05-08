library(tidyverse)
library(here)

path <- "script/01-intro.Rmd"

process_file <- function(path) {
  id <- gsub("^([0-9][0-9]).*$", "\\1", basename(path))

  input <- readLines(here(path))
  writeLines(gsub("^(```[{]r )[0-9][0-9]",  paste0("\\1", id), input), here(path))
}

files <- dir("script", pattern = "^[0-9][0-9].*[.]Rmd$", full.names = TRUE)

walk(files, process_file)
