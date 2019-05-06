library(tidyverse)
library(here)

process_file <- function(path) {
  rmd_path <- here("script", gsub("R$", "Rmd", basename(path)))

  file_id <- gsub("^([^-]+)-.*$", "\\1", basename(path))
  lines <- readLines(path)

  if (grepl("^### ", lines[[1]])) {
    caption <- gsub("^### ", "", lines[[1]])
    lines <- lines[-1:-2]
  } else {
    caption <- "<No caption defined>"
  }

  caption <- paste0("## ", caption)

  lines <- c(paste0("# Setup ", basename(path)), lines)

  comment <- grepl("^#", lines)


  tibble(lines, comment) %>%
    mutate(id = cumsum(comment)) %>%
    select(-comment) %>%
    nest(-id) %>%
    mutate(header = map_chr(data, list("lines", 1L))) %>%
    mutate(comment = gsub("^# ", "", header)) %>%
    mutate(chunk_name = paste0(file_id, "-", snakecase::to_snake_case(header, sep_out = "-"))) %>%
    mutate(code = map_chr(map(data, tail, -1), ~ paste(.$lines, collapse = "\n"))) %>%
    mutate(code = gsub("\n+$", "", code)) %>%
    mutate(has_code = nchar(code) > 0) %>%
    select(id, comment, chunk_name, code, has_code) %>%
    mutate(chunk = paste0("<!-- ",  comment, " -->\n", if_else(has_code, paste0("```{r ", chunk_name, "}\n", code, "\n```\n\n\n"), ""))) %>%
    pull() %>%
    glue::glue_collapse(sep = "") %>%
    gsub("\n+$", "", .) %>%
    c(paste0("```{r ", file_id, "-remove-all, include = FALSE}\nrm(list = ls())\n```\n\n"), caption, "", .) %>%
    writeLines(rmd_path)
}

files <- dir("proj/script", full.names = TRUE)

walk(files, process_file)

tibble(files) %>%
  mutate(basename = basename(files)) %>%
  mutate(group = substr(basename, 1, 1)) %>%
  mutate(rmd_path_code = paste0('here("script", "', basename, 'md")')) %>%
  mutate(chunk = paste0('```{r child = ', rmd_path_code, '}\n```')) %>%
  nest(-group) %>%
  mutate(chunks = map_chr(data, ~ glue::glue_collapse(.$chunk, sep = "\n\n"))) %>%
  mutate(file = paste0("script/", group, ".Rmd")) %>%
  select(text = chunks, con = file) %>%
  pwalk(writeLines)
