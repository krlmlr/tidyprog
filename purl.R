library(tidyverse)
library(here)

path <- "script/01-intro.Rmd"

process_file <- function(path) {
  r_path <- here("proj", "script", gsub("Rmd$", "R", basename(path)))

  input <- readLines(here(path))
  header <- input[[6]]
  knitr::purl(text = input[-(1:6)], output = r_path, documentation = 0L)
  r_path
}

files <- dir("script", pattern = "^[0-9][0-9].*[.]Rmd$", full.names = TRUE)

paths <- map_chr(files, process_file)

all_files <- dir(here("proj", "script"), full.names = TRUE)
to_remove <- setdiff(all_files, paths)
unlink(to_remove)
