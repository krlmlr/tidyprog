### Argument matching



# Call matching
use_names <- function(one = 1, two = 2) {
  list(one = one, two = two)
}

use_names(3, 4)
use_names(one = 3, 4)
use_names(3, one = 4)
use_names(one = 3, two = 4)
use_names(two = 3, one = 4)

# Partial matching
use_names(o = 3, 4)
use_names(3, o = 4)
use_names(o = 3, t = 4)
use_names(t = 3, o = 4)

# The ellipsis is useful to enforce naming of arguments
only_names <- function(..., one = 1, two = 2) {
  list(one = one, two = two)
}

only_names(3, 4)
only_names(one = 3, 4)
only_names(one = 3, two = 4)
only_names(o = 3, t = 4)

# Arguments in ellipsis can be captured via list()
ellipsis_test <- function(...) {
  args <- list(...)
  names(args)
}

ellipsis_test(a = 1, 2, c = 3:5)

# Arguments in ellipsis can be accessed with ..1, ..2 etc.
ellipsis_direct_test <- function(...) {
  list(..1, ..2)
}

ellipsis_direct_test(a = 1, 2, c = 3:5)

# Exercises

# Naming, not naming or partly naming parameters in functions calls? What does the following return and why?
use_some_names <- function(one = 1, ..., two = 2) {
  list(one = one, two = two)
}

use_some_names(3, 4)
use_some_names(one = 3, 4)
use_some_names(3, one = 4)
use_some_names(one = 3, two = 4)
use_some_names(two = 4, 3)

## Program defensively!
enforce_names <- function(..., one = 1, two = 2) {
  extra_args <- list(...)
  stopifnot(length(extra_args) == 0)

  list(one = one, two = two)
}

try(enforce_names(3, 4))
try(enforce_names(one = 3, 4))
try(enforce_names(3, one = 4))
try(enforce_names(two = 4, 3))
try(enforce_names(o = 3, t = 4))
enforce_names(one = 3, two = 4)
