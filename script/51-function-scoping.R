### Scope

a <- 5

# A function can access global variables:
f <- function() {
  a
}

f()

# When a function writes to a variable, it always writes in scope
f <- function() {
  a <- 2
  a
}

f()
a

# Global variables are a (hidden) part of a function's interface!
# Best practice: self-contained functions, independent of global variables


## Exercises:
invisible()
