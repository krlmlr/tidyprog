library(tidyverse)
library(here)

path <- "script/01-intro.Rmd"

process_file <- function(path) {
  r_path <- here("proj", "script", gsub("Rmd$", "R", basename(path)))

  input <- readLines(here(path))
  header <- input[[6]]
  knitr::purl(text = input[-(1:6)], output = r_path, documentation = 0L)
}

files <- dir("script", pattern = "[.]Rmd$", full.names = TRUE)

walk(files, process_file)
