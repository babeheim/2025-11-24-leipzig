

# Download gapminder.csv from:
https://swcarpentry.github.io/r-novice-gapminder/02-project-intro.html

# ifelse

has_high_blood_pressure <- TRUE
ifelse(has_high_blood_pressure, print("watch out!"), print("all good!"))

has_high_blood_pressure <- FALSE
ifelse(has_high_blood_pressure, print("watch out!"), print("all good!"))

has_high_blood_pressure <- FALSE
if (has_high_blood_pressure) {
  print("watch out!")
} else {
  print("all good!")
}

has_high_blood_pressure <- TRUE
ifelse(has_high_blood_pressure, "watch out!", "all good!")

answer <- print("watch out")

# Lists (vs Vectors)

x <- c("Banana", 3, NA)

x[1]

# unnamed list examples
y <- list("Banana", 3, NA)

z <- list(x, c("Bret", "Connor", "Alejandra"), 914)

class(y[1])
class(y[[1]])

str(y)
str(z)

library(dplyr)
# install.packages("dplyr")

# named list:
my_pet <- list(
  name = "Penelope",
  age = 2,
  likes = c("socks", "bark", "cuddles")
)

my_pet[[3]]
my_pet$likes

# how would I pull the FIRST element of the 'likes' entry for penny?
my_pet$likes[1]
my_pet[[3]][1]

my_pet$likes[[1]]

test <- 1:5
test[[1]]

# [] - gives back whatever format its already in
# [[]] - gives back whatever is stored at that location

pets <- list(
  name = c("Penelope", "Thor", "Cosmos", "Louie"),
  type = c("Dog", "Dog", "Cat", "Dog"),
  notes = "pets collected from day 2 of swc 2025",
  num_pets = 4
)

# (non-functional trailing comma version)
pets_df <- data.frame(
  name = c("Penelope", "Thor", "Cosmos", "Louie"),
  type = c("Dog", "Dog", "Cat", "Dog"),
)

pets_df <- data.frame(
  name = c("Penelope", "Thor", "Cosmos", "Louie"),
  type = c("Dog", "Dog", "Cat", "Dog")
)

class(pets_df[1])
pets_df[[1]]

pets_df$name


# working with data frames 

pets_df[c("name", "type")]

dplyr::select(pets_df, name, type) # always works
select(pets_df, name, type)        # only works if library(dplyr) already called
                                   # (and no other libraries are using 'select')

pets_df[1:2, ] # gives all info on first element
class(pets_df[1:2,])

new_pet <- data.frame(
  type = "Fish",
  name = "George"
)

dim(pets_df)
dim(new_pet)

nrow(pets_df) # 5 elements / pets

ncol(pets_df) 
length(pets_df)

# to add new entries: rbind and dplyr::bind_rows

rbind(pets_df, new_pet)

dplyr::bind_rows(pets_df, new_pet)

# merging in lots of new data

rbind(pets_df, new_pet, new_pet)

dplyr::bind_rows(pets_df, new_pet, new_pet)


# working with gapminder.csv

getwd()
setwd("/home/bret/Desktop/swc-2025")
list.files() # shows whats in the working directory

gapminder <- read.table("gapminder_data.csv", sep = ",", header = TRUE)
gapminder <- read.csv("gapminder_data.csv")

str(gapminder)

# pipes versus nested functions
levels(as.factor(gapminder$country))
gapminder$country %>% as.factor() %>% levels()

gapminder$year %>% as.factor() %>% levels()

unique(gapminder$year)

table(gapminder$continent)

# 142 countries! 
# 12 appearances for each country
# 12 * 142 = 1704 rows!

class(1:5)


choices <- factor(
  c("left", "right", "right", "right", "middle", "left"),
  levels = c("left", "right", "middle")
)


# using dplyr for exploratory analysis

library(dplyr)

# ctrl + shift + m - makes a pipe!

gapminder %>% 
  summarize(
    n_countries = length(unique(country)),
    n_continents = length(unique(continent)),
    first_year = min(year),
    last_year = max(year)
  )

gapminder %>% 
  filter(continent == "Asia") %>%
  summarize(
    n_countries = length(unique(country)),
    n_continents = length(unique(continent)),
    first_year = min(year),
    last_year = max(year)
  )

gapminder %>% 
  filter(continent == "Americas" | continent == "Oceania") %>%
  summarize(
    n_countries = length(unique(country)),
    n_continents = length(unique(continent)),
    first_year = min(year),
    last_year = max(year)
  )

gapminder %>% 
  filter(continent %in% c("Americas", "Oceania")) %>%
  summarize(
    n_countries = length(unique(country)),
    n_continents = length(unique(continent)),
    first_year = min(year),
    last_year = max(year)
  )

gapminder %>% 
  group_by(continent) %>%
  summarize(
    n_countries = length(unique(country)),
    n_continents = length(unique(continent)),
    first_year = min(year),
    last_year = max(year),
    lifeExp_avg = mean(lifeExp),
    lifeExp_min = min(lifeExp),
    lifeExp_max = max(lifeExp)
  ) %>%
  as.data.frame()

continent_stats <- gapminder %>% 
  filter(continent != "Oceania") %>%
  group_by(continent) %>%
  summarize(
    n_countries = length(unique(country)),
    n_continents = length(unique(continent)),
    first_year = min(year),
    last_year = max(year),
    lifeExp_avg = mean(lifeExp),
    lifeExp_min = min(lifeExp),
    lifeExp_max = max(lifeExp)
  ) %>%
  as.data.frame()

# bret's fav

gapminder %>% 
  filter(continent != "Oceania") %>%
  group_by(continent) %>%
  summarize(
    n_countries = length(unique(country)),
    n_continents = length(unique(continent)),
    first_year = min(year),
    last_year = max(year),
    lifeExp_avg = mean(lifeExp),
    lifeExp_min = min(lifeExp),
    lifeExp_max = max(lifeExp)
  ) %>%
  as.data.frame() -> continent_stats

write.csv(continent_stats, "continent_stats.csv", row.names = FALSE)

# task:
# filter to the countries of the Americas
# and calculate avg GDP per capita, PER COUNTRY (e.g. group_by(country))

gapminder %>%
  filter(continent == "Americas") %>%
  group_by(country) %>%
  summarize(
    gdpPercap_avg = mean(gdpPercap)
  )






gapminder %>% 
  filter(continent %in% c("Africa", "Asia", "Americas")) %>%
  group_by(continent, year) %>%
  summarize(
    n_countries = n(),
    lifeExp_avg = mean(lifeExp)
  ) %>%
  arrange(desc(lifeExp_avg)) %>%
  as.data.frame() -> continent_year_stats






# how to clean and standardize names

df <- data.frame(
  name = c("Jose", "Jse", "jose", "Alex", "Alexa"),
  weight= c(12, 14, 12, 15, 15)
)

df$clean_name <- NA
df$clean_name[df$name %in% c("Jose", "jose")] <- "Jose"
df$clean_name[df$name %in% c("Alex", "Alexa")] <- "Alex"

df$name == "Jose" | df$name == "Jse" | df$name == "jose"

my_joses <- c("Jose", "Jse", "jose")
df$name %in% my_joses












# getting help!

read.table()

bind_rows()

help(read.table)

read.csv2()




# notes at the end

library(foreign)








