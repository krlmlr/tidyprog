### Construction

c(1, 2, 3)
c(1:3, 5)
c(1:3, "5")

# Use list() to construct a list, all elements can have different types and lengths:
list(1, 2, 3)
list(1:3, 5)
list(1:3, "5")

# Lists can be nested:
nested <- list(
  1:3,
  list(4, "5"),
  list(
    list(letters[6:8]),
    9
  )
)

nested
str(nested)

# Vectors and lists can have names:
c(a = 1, b = 2, c = 3)
list(a = 1:3, b = 5)
rlang::set_names(1:3, letters[1:3])

# Preview: vctrs::list_of() to construct typed lists
#vctrs::list_of(1, 2, 3)
#try(vctrs::list_of(1, 2, "3"))
#vctrs::list_of(letters[1:3], "e")

# Exercises

c(a = list(1:3), b = list(4:5))
list(a = list(1:3), b = list(4:5))
