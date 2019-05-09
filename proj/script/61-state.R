### Dealing with state

library(tidyverse)

# Write our own implementation of sum():
1 + 2 + 3
`+`(1, 2)
`+`(`+`(1, 2), 3)

# Generalization: reduce()
reduce(1:3, `+`)
reduce(1:3, ~ ..1 + ..2)

# Initialization is implicit, but can be provided explicitly:
reduce(1:3, `+`, .init = 0)

# Operation does not need to commute or be associative,
# can be used to update state
diag(2)
reduce(1:3, `*`, .init = diag(2))

# Write our own implementation of cumsum():
accumulate(1:3, `+`)
