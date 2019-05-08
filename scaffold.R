library(tidyverse)
library(here)

# Overwritten further below
path <- dir("proj/script", full.names = TRUE)
path <- path[[1]]
rmd_path <- here("script", gsub("R$", "Rmd", basename(path)))

setup_first <- function(x) {
  x[[1]] <- paste0("<details><summary>Setup code</summary>\n", gsub("\n+$", "\n", x[[1]]), "</details>\n\n\n")
  x
}

process_file <- function(path, rmd_path) {
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

  split <-
    tibble(lines) %>%
    mutate(comment = grepl("^#", lines)) %>%
    mutate(flip = coalesce(comment != lag(comment), TRUE)) %>%
    mutate(id = (cumsum(flip) + 1) %/% 2) %>%
    select(-flip) %>%
    nest(-id, -comment) %>%
    mutate(data = map(data, pull))

  headers <-
    split %>%
    filter(comment) %>%
    select(-comment) %>%
    mutate(chunk_name = paste0(file_id, "-", snakecase::to_snake_case(map_chr(data, 1), sep_out = "-"))) %>%
    select(-data)

  split %>%
    mutate(data = map_chr(data, ~ glue::glue_collapse(., "\n"))) %>%
    mutate(data = if_else(row_number() == 1, paste0("#", caption, "\n"), gsub("\n+$", "", data))) %>%
    mutate(comment = if_else(comment, "comment", "code")) %>%
    spread(comment, data) %>%
    left_join(headers, by = "id") %>%
    select(id, comment, chunk_name, code) %>%
    mutate(chunk = setup_first(paste0("```{r include = FALSE}\n", comment, "\n```\n", "```{r ", chunk_name, "}\n", code, "\n```\n\n\n"))) %>%
    pull() %>%
    glue::glue_collapse(sep = "") %>%
    gsub("\n+$", "", .) %>%
    c(paste0("```{r ", file_id, "-remove-all, include = FALSE}\nrm(list = ls())\n```\n\n"), caption, "", .) %>%
    writeLines(rmd_path)
}

path <- dir("proj/script", full.names = TRUE)
rmd_path <- here("script", gsub("R$", "Rmd", basename(path)))

files_df <-
  tibble(r = path, rmd = rmd_path) %>%
  mutate_all(list(mtime = ~ file.info(.)$mtime))

files_df %>%
  filter(is.na(rmd_mtime) | r_mtime > rmd_mtime) %>%
  select(path = r, rmd_path = rmd) %>%
  pwalk(process_file)

files_df %>%
  mutate(basename = basename(r)) %>%
  mutate(group = substr(basename, 1, 1)) %>%
  mutate(rmd_path_code = paste0('here("script", "', basename, 'md")')) %>%
  mutate(chunk = paste0('```{r child = ', rmd_path_code, '}\n```')) %>%
  nest(-group) %>%
  mutate(chunks = map_chr(data, ~ glue::glue_collapse(.$chunk, sep = "\n\n"))) %>%
  mutate(file = paste0("script/", group, ".Rmd")) %>%
  select(text = chunks, con = file) %>%
  pwalk(writeLines)
