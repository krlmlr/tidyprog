library(tidyverse)
library(here)

path <- dir("../tidyprog-proj/script", full.names = TRUE)[[1]]

process_file <- function(path) {
  rmd_path <- here("script", gsub("R$", "Rmd", basename(path)))

  lines <- c(paste0("# Setup ", basename(path)), readLines(path))
  comment <- grepl("^#", lines)
  tibble(lines, comment) %>%
    mutate(id = cumsum(comment)) %>%
    select(-comment) %>%
    nest(-id) %>%
    mutate(header = map_chr(data, list("lines", 1L))) %>%
    mutate(comment = gsub("^# ", "", header)) %>%
    mutate(chunk_name = snakecase::to_snake_case(header, sep_out = "-")) %>%
    mutate(code = map_chr(map(data, tail, -1), ~ paste(.$lines, collapse = "\n"))) %>%
    select(id, comment, chunk_name, code) %>%
    mutate(chunk = paste0("<!--",  comment, " -->\n", "```{r ", chunk_name, "}\n", code, "```")) %>%
    pull() %>%
    glue::glue_collapse(sep = "\n\n\n") %>%
    writeLines(rmd_path)
}

files <- dir("../tidyprog-proj/script", full.names = TRUE)

walk(files, process_file)
