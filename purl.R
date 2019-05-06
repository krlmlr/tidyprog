library(tidyverse)
library(here)

path <- "script/01-intro.Rmd"

safe_copy <- function(source, target) {
  if (!file.exists(target) || !identical(readLines(source), readLines(target))) {
    file.copy(source, target, overwrite = TRUE)
  }
  invisible()
}

safe_purl <- function(text, output) {
  tmp <- tempfile("purl", fileext = ".R")
  knitr::purl(text = text, output = tmp, documentation = 0L)
  safe_copy(tmp, output)
}

process_file <- function(path) {
  r_path <- here("proj", "script", gsub("Rmd$", "R", basename(path)))

  input <- readLines(here(path))
  header <- input[[6]]
  safe_purl(text = input[-(1:6)], output = r_path)
  r_path
}

files <- dir("script", pattern = "^[0-9][0-9].*[.]Rmd$", full.names = TRUE)

paths <- map_chr(files, process_file)

all_files <- dir(here("proj", "script"), full.names = TRUE)
to_remove <- setdiff(all_files, paths)
unlink(to_remove)
