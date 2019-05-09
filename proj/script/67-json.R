### Accessing APIs

library(tidyverse)
library(here)

# Use httr::GET() for GET requests:
req <- httr::GET("https://photon.komoot.de/api/?q=Paradeplatz&limit=3")

# Wait for the request to be processed:
httr::stop_for_status(req)

# Read the response:
content <- httr::content(req)
content

# Display the original response:
text_content <- httr::content(req, as = "text")
cat(text_content)

# Pretty-print the original response:
cat(jsonlite::prettify(text_content))
