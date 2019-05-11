# tidyprog

<!-- badges: start -->
[![Travis build status](https://travis-ci.org/krlmlr/tidyprog.svg?branch=master)](https://travis-ci.org/krlmlr/tidyprog)
<!-- badges: end -->

Programming in the tidyverse.

## Hacking

### Creating a new script

1. Draft an `.R` script in `proj/script/??-slug.R`, use an existing script as template

2. Run `make scaffold` to create the corresponding `.Rmd` file

3. When happy with the contents, work on the `.Rmd` file to add text

4. Run `make purl` to update the `.R` file

5. At this stage, running `make scaffold` again after updating the `.R` file will erase your text. Make sure to commit before, and use a visual differ to sync

6. Update the website with `git push`

### Sync

The `proj` subtree is a subtree of https://github.com/krlmlr/tidyprog-proj. Clone in the same level of the directory hierarchy as the master project, and sync the `website` branch of that repo with `make pull` and `make push`.

### Mass renaming

Use `qmv` on the `.Rmd` files, then `make id purl`

### Testing

Run `make test`, currently not integrated in CI
