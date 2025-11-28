
# Advanced Data Manipulation!

library(tidyr)
library(dplyr)

# more lists!

pets_df <- data.frame(
  name = c("Penelope", "Thor", "Cosmos", "Louie", "George"),
  type = c("Dog", "Dog", "Cat", "Dog", "Fish"),
  likes = c("Socks", "Girls", "Cucumbers", "Pats", "Escape"),
  notes = c(NA, NA, "Recorded with iPhone", NA, NA)
)

pets_df2 <- list(
  list(name = "Penelope", type = "Dog", likes = "Socks"),
  list(name = "Cosmos", type = "Cat", likes = "Cucumbers", notes = "Recorded with iPhone"),
  list(name = "Thor", type = "Dog", likes = "Girls")
) %>% bind_rows() %>% as.data.frame()

pets_df3 <- read_json("pets.json") %>% bind_rows() %>% as.data.frame()

pets_df3 <- read_json("pets.json", simplifyVector = TRUE)


##### data structures!

d_normal <- data.frame(
  country = c("China", "China", "USA", "USA"),
  year = c(1997, 1998, 1997, 1998),
  pop = c(1000, 1200, 300, 310),
  gdpPercap = c(40, 45, 65, 70)
)

# Exercise: write d_long and d_wide for this data

d_wide <- data.frame(
  country = c("China", "USA"),
  pop_1997 = c(1000, 300),
  pop_1998 = c(1200, 310),
  gdpPercap_1997 = c(40, 65),
  gdpPercap_1998 = c(45, 70)
)

d_wide2 <- list(
  list(
    country = "China",
    pop_1997 = 1000,
    pop_1998 = 1200,
    gdpPercap_1997 = 40,
    gdpPercap_1998 = 45
  ),
  list(
    country = "USA",
    pop_1997 = 300,
    pop_1998 = 310,
    gdpPercap_1997 = 65,
    gdpPercap_1998 = 70
  )
) %>% bind_rows() %>% as.data.frame()


# long format:

d_long <- list(
  list(country = "China", year = "1997", attribute = "pop",       value = 1000),
  list(country = "China", year = "1998", attribute = "pop",       value = 1200),
  list(country = "USA",   year = "1997", attribute = "pop",       value = 300),
  list(country = "USA",   year = "1998", attribute = "pop",       value = 310),
  list(country = "China", year = "1997", attribute = "gdpPercap", value = 40),
  list(country = "China", year = "1998", attribute = "gdpPercap", value = 45),
  list(country = "USA",   year = "1997", attribute = "gdpPercap", value = 65),
  list(country = "USA",   year = "1998", attribute = "gdpPercap", value = 70)
) %>% bind_rows() %>% as.data.frame()



# translating between data structures!!

library(tidyr)
library(dplyr)
# library(tidyverse) # has both


# normal to long

d_normal %>%
  pivot_longer(
    cols = c("pop", "gdpPercap"),
    names_to = "attribute",
    values_to = "value"
  ) %>% as.data.frame()

# long to normal

d_long %>%
  pivot_wider(
    names_from = attribute,
    values_from = value
  )




# wide to long

## (not quite perfect version)
d_wide %>%
  pivot_longer(
    cols = c("pop_1997", "pop_1998", "gdpPercap_1997", "gdpPercap_1998"),
    names_to = "attribute_year",
    values_to = "value"
  )

d_wide %>%
  pivot_longer(
    cols = c(starts_with("pop"), starts_with("gdpPercap")),
    names_to = "attribute_year",
    values_to = "value"
  ) %>%
  separate(
    attribute_year,
    into = c("attribute", "year"),
    sep = "_"
  )


# wide to normal
# wide (to long) to normal

d_wide %>%
  pivot_longer(
    cols = c(starts_with("pop"), starts_with("gdpPercap")),
    names_to = "attribute_year",
    values_to = "value"
  ) %>%
  separate(
    attribute_year,
    into = c("attribute", "year"),
    sep = "_"
  ) %>%
  pivot_wider(
    names_from = attribute,
    values_from = value
  )

# long to wide

d_long %>%
  unite(column_names, attribute, year, sep = "_") %>%
  pivot_wider(
    names_from = column_names, # new variable, created in the pipe
    values_from = value
  )

# normal to wide
# normal (to long) to wide

d_normal %>%
  pivot_longer(
    cols = c("pop", "gdpPercap"),
    names_to = "attribute",
    values_to = "value"
  ) %>%
  unite(column_names, attribute, year, sep = "_") %>%
  pivot_wider(
    names_from = column_names, # new variable, created in the pipe
    values_from = value
  ) %>% as.data.frame()


# with column re-ordering...

d_normal %>%
  pivot_longer(
    cols = c("pop", "gdpPercap"),
    names_to = "attribute",
    values_to = "value"
  ) %>%
  unite(column_names, attribute, year, sep = "_") %>%
  pivot_wider(
    names_from = column_names, # new variable, created in the pipe
    values_from = value
  ) %>%
  select(country, starts_with("pop"), starts_with("gdpPercap")) %>%
  as.data.frame()

# another flavor...

d_normal %>%
  pivot_longer(
    cols = c("pop", "gdpPercap"),
    names_to = "attribute",
    values_to = "value"
  ) %>%
  unite(column_names, attribute, year, sep = "_") %>%
  pivot_wider(
    names_from = column_names, # new variable, created in the pipe
    values_from = value
  ) %>%
  select(country, starts_with("pop"), everything()) %>%
  as.data.frame()



# gapminder

gapminder <- read.csv("gapminder_data.csv")
# 1704 obs x 6 variables

gapminder %>%
  pivot_longer(
    cols = c("pop", "gdpPercap", "lifeExp"),
    names_to = "attribute",
    values_to = "value"
  ) -> gapminder_long
# 5112 obs x 5 variables

gapminder_long %>%
  unite(column_names, attribute, year, sep = "_") %>%
  pivot_wider(
    names_from = column_names, # new variable, created in the pipe
    values_from = value
  ) %>%
  select(country, starts_with("pop"), everything()) %>%
  as.data.frame() -> gapminder_wide
# 142 obs x 38 variables


