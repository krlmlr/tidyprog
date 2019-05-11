library(rlang)

# Use quos() to understand what will happen:
quos(x = a)

a <- sym("b")
x_quos <- quos(x = !!a)
x_quos

# quos() can be nested:
quos(y = c, !!!x_quos)
