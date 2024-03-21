wine_geo <- readr::read_csv(here::here('wine country geo - Sheet1.csv'))
g <- dplyr::glimpse
g(wine_geo)
library(dplyr)
wine_geo <- wine_geo |>
  mutate(drop = if_else(is.na(drop), FALSE, drop)) |>
  filter(drop!=TRUE) |>
  mutate(hours = if_else(is.na(opens), '',
                         paste(format(as.POSIXct(opens), '%I:%M %p'),'-',
                               format(as.POSIXct(closes), '%I:%M %p'))),
         date = as.Date(date),
         date_formatted = format(date, '%a %b %d'),
         across(c(comments, date_formatted), \(x) tidyr::replace_na(x, '')),
         label = glue::glue('<b>{name}</b><br>{date_formatted}<br>{type}<br>{hours}<br>{comments}'))

