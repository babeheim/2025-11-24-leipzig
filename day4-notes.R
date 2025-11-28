
# Links that we used
# https://r-graph-gallery.com/
# https://r-charts.com/ggplot2/themes/
# http://tiny.cc/swc_leipzig_notes

# See ggplot2 cheat sheet here
# https://rstudio.github.io/cheatsheets/html/data-visualization.html

library(dplyr)
library(ggplot2)

#set working directory to your current location
#setwd("~/Desktop/sw_carpentry_day4")
getwd()

gapminder <- read.csv("gapminder-data.csv")
gapminder

gapminder %>% 
  filter(country=="Germany")

# Command to initialize
ggplot()


# Two different ways to get data into ggplot, through parameters or pipes.
ggplot(data=gapminder)

gapminder %>% 
  ggplot()

# Make the grid
ggplot(data=gapminder, mapping= aes(x = gdpPercap, y = lifeExp))

# Plot the points on them
ggplot(data=gapminder, mapping= aes(x = gdpPercap, y = lifeExp)) +
  geom_point()

# Make a subset for 2007
gapminder_2007 <- gapminder %>% 
  filter(year==2007)

# The wrong way to introduce data :)  - use = not <- within parameters
ggplot(data = second_data <- gapminder_2007, mapping = aes(x=gdpPercap,y=lifeExp)) +
  geom_point()

help(ggplot)

# See what aes() function does in the mapping parameter
aes(x=gdpPercap,y=lifeExp)

str(aes(x=gdpPercap,y=lifeExp))

#Sequence does not matter if the parameter name is specified
ggplot(mapping= aes(x=gdpPercap,y=lifeExp),data=second_data) +
  geom_point()

# But it does not work if the parameter names are not specitied
ggplot(aes(x=gdpPercap,y=lifeExp),second_data) +
  geom_point()

# Though parameters have a basic order, which can be relied upon here.
ggplot(second_data,aes(x=gdpPercap,y=lifeExp)) +
  geom_point()

# Data can be entered thorugh the pipe
gapminder_2007 %>% 
  ggplot(aes(x=gdpPercap,y=lifeExp))+
  geom_point()

# Also x and y in aes can be based on just the order of it.
gapminder_2007 %>% 
  ggplot(aes(gdpPercap,lifeExp))+
  geom_point()

########################
# Task
# the relationship between life expectancy and time for the whole of gapminder dataset.
########################

# Names to see the columns in a table
names(gapminder)
colnames(gapminder)

# Task answer
ggplot(data= gapminder, aes(x= year,y = lifeExp))+
  geom_point()

# Add colors for continent
ggplot(data= gapminder, aes(x= year,y = lifeExp, color = continent))+
  geom_point()

# Use lines instead of points. Line connects all continents together now - not very useful.
ggplot(data= gapminder, aes(x= year,y = lifeExp, color = continent))+
  geom_line()

# Lines without the grouping. Even less useful.
ggplot(data= gapminder, aes(x= year,y = lifeExp))+
  geom_line()


# Better with grouping on country.
ggplot(data= gapminder, aes(x= year,y = lifeExp, color = continent, group= country))+
  geom_line()

# Layers can be combined
ggplot(data= gapminder, aes(x= year,y = lifeExp, color = continent, group= country))+
  geom_line()+
  geom_point()

# The aes() can be in different levels. Base layer applies to all, other layers just within them.
ggplot(data= gapminder, aes(x= year,y = lifeExp))+
  geom_line(aes(color = continent, group= country))+
  geom_point()

########################
# Task
# reverse the layer ordering
########################

ggplot(data= gapminder, aes(x= year,y = lifeExp))+
  geom_point()+
  geom_line(aes(color = continent, group= country))

########################
# Task
# Pick 3 countries and plot this relationship for each
########################

# Tips
# filter()
# %in% c()
# selected_countries_gapminder <- 

gapminder %>% 
  filter(country=="Germany" & country=="Brazil")

gapminder %>% 
  filter(country %in% c("Brazil", "Germany", "Japan")) %>% 
  ggplot(aes(x=year,y=lifeExp))+
  geom_point()+
  geom_line(aes(color=country))

# Difference between geom_line() and geom_path()

gapminder %>% 
  filter(country %in% c("Brazil", "Germany", "Japan")) %>% 
  ggplot(aes(x=gdpPercap,y=lifeExp))+
  geom_point(aes(color=country))+
  geom_line(aes(color=country))

gapminder %>% 
  filter(country %in% c("Brazil", "Germany", "Japan")) %>% 
  ggplot(aes(x=gdpPercap,y=lifeExp))+
  geom_point(aes(color=country))+
  geom_path(aes(color=country))

# Add a text layer
gapminder %>% 
  filter(country %in% c("Brazil", "Germany", "Japan")) %>% 
  ggplot(aes(x=gdpPercap,y=lifeExp))+
  geom_point(aes(color=country))+
  geom_path(aes(color=country))+
  geom_text(aes(label=year))


# Path works with the order of the dataframe. Currently by year, but could be different.
gapminder %>% 
  filter(country %in% c("Brazil", "Germany", "Japan")) %>% 
  arrange(desc(year)) %>% 
  ggplot(aes(x=gdpPercap,y=lifeExp))+
  geom_point(aes(color=country))+
  geom_path(aes(color=country))+
  geom_text(aes(label=year))


# Scales. scale_x_log10(), scale_size()
gapminder %>% 
  filter(year == 2007) %>% 
  ggplot(aes(x=gdpPercap, y=lifeExp, size=pop))+
  geom_point(aes(color=continent))+
  scale_x_log10()+
  scale_size(range=c(0.1,20))

# scale_x_continuous() can add up to the same.
gapminder %>% 
  filter(year == 2007) %>% 
  ggplot(aes(x=gdpPercap, y=lifeExp, size=pop))+
  geom_point(aes(color=continent))+
  scale_x_continuous(transform="log10")+
  scale_size(range=c(0.1,20))


# With colours and point borders, and themes
# See more themes here: https://r-charts.com/ggplot2/themes/
gapminder %>% 
  filter(year == 2007) %>% 
  ggplot(aes(x=gdpPercap, y=lifeExp, size=pop))+
  geom_point(aes(fill=continent), color= "black",alpha=0.5, shape = 21)+
  scale_x_log10()+
  scale_fill_manual(values=c("blue","green", "red", "yellow", "red"))+
  scale_size(range=c(0.1,20))+
  theme_light()+
  guides(size=FALSE,color=FALSE)+
  labs(x="GDP per capita",y= "Life expectancy", title= "Wealth vs life expectancy by continent", subtitle = "Data from 2007")



# theme_classic() here
gapminder %>% 
  filter(year == 2007) %>% 
  ggplot(aes(x=gdpPercap, y=lifeExp, size=pop))+
  geom_point(aes(fill=continent), color= "black",alpha=0.5, shape = 21)+
  scale_x_log10()+
  scale_fill_manual(values=c("blue","green", "red", "yellow", "red"))+
  scale_size(range=c(0.1,20))+
  theme_classic()+
  guides(size=FALSE,color=FALSE)+
  labs(x="GDP per capita",y= "Life expectancy", title= "Wealth vs life expectancy by continent", subtitle = "Data from 2007")

# See websites like https://coolors.co/ and http://colormind.io/ for color sets.

# Think of the accessibility in colors
# See also the package cols4all in R https://cols4all.github.io/cols4all-R/
# And viridis cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html


# Different shapes
gapminder %>% 
  ggplot(aes(x=gdpPercap,y=lifeExp))+
  geom_point(alpha=0.5, shape="+")

gapminder %>% 
  ggplot(aes(x=gdpPercap,y=lifeExp,shape=continent))+
  geom_point(alpha=0.5)


# High and low countries
gapminder_2007 %>% 
  filter(lifeExp==max(lifeExp)|lifeExp==min(lifeExp)) %>% 
  ggplot(aes(x=gdpPercap,y=lifeExp,label=country))+
  geom_text()

# Save data as variable
first_and_last <- gapminder_2007 %>% 
  filter(lifeExp==max(lifeExp)|lifeExp==min(lifeExp))

# Add a text layer specifically for high and low values
gapminder_2007 %>% 
  ggplot(aes(x=gdpPercap,y=lifeExp,label=country))+
  geom_point()+
  geom_text(data=first_and_last)

# Two subsets presented separately
germany <- gapminder %>% filter(country=="Germany")
france <- gapminder %>% filter(country=="France")

# Each layer can refer to a separate dataset.
ggplot(aes(x=gdpPercap,y=lifeExp))+
  geom_point(data=germany,color="red")+
  geom_point(data=france,color="blue")


# Back to the original graph
gapminder_2007 %>% 
  ggplot(aes(x=gdpPercap, y=lifeExp, size=pop,color=continent))+
  geom_point()+
  scale_x_log10()

# Viridis package for colorblind friendly colors
# See their overview here: cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html
gapminder_2007 %>% 
  ggplot(aes(x=gdpPercap, y=lifeExp, size=pop,color=continent))+
  viridis::scale_color_viridis(discrete=T)+
  geom_point()+
  scale_x_log10()

# Brewer package for color sets within the ggplot
gapminder_2007 %>% 
  ggplot(aes(x=gdpPercap, y=lifeExp, size=pop,color=continent))+
  scale_color_brewer()+
  geom_point()+
  scale_x_log10()



# Gallery of graphics: https://r-graph-gallery.com/
# To get the beeswarm package from the gallery.
install.packages("ggbeeswarm")


library(dplyr)
library(ggplot2)
library(ggbeeswarm)

# A beeswarm plot
gapminder %>% 
  ggplot(aes(x=year, y=lifeExp, color=continent))+
  ggbeeswarm::geom_beeswarm()


# Install plotly for interactive graphs
# Plotly has it's own syntax in R too https://plotly.com/r/, here we can just rely on the ggplot link with plotly.
install.packages("plotly")

library(plotly)

# An interactive graph with beeswarms
gapminder %>% 
  ggplot(aes(x=year, y=lifeExp, color=continent))+
  ggbeeswarm::geom_beeswarm()

ggplotly()

# We add a text field.
gapminder %>% 
  ggplot(aes(x=year, y=lifeExp, color=continent, text=paste0("country: ", country)))+
  geom_jitter()

ggplotly()

# We can explore our main graph with this
gapminder_2007 %>% 
  ggplot(aes(x=gdpPercap, y=lifeExp, color=continent, text=paste0("country: ", country)))+
  geom_point()+
  scale_x_log10()

ggplotly()


# We can add a regression line. Note that group=continent gives the grouping variable for the geom_smooth(). It is possible to set them in different layers separately.
gapminder_2007 %>% 
  ggplot(aes(x=gdpPercap, y=lifeExp, color=continent, text=paste0("country: ", country),group=continent))+
  geom_point()+
  scale_x_log10()+
  geom_smooth(method="lm")


# group = 1 would make all the data points into one group, even if for other parameters they are kept separate.
gapminder_2007 %>% 
  ggplot(aes(x=gdpPercap, y=lifeExp, color=continent, text=paste0("country: ", country),group=continent))+
  geom_point()+
  scale_x_log10()+
  geom_smooth(method="lm")


# Plotly allows an easy way to animate the graph, two more values need to be given, frame and ids. Group works now within each year for each continent, and plotly interpolates the values between them. If we don't set ids, the animation may take the nearest point and make mistakes in the animations.

gapminder %>% 
  ggplot(aes(x=gdpPercap, y=lifeExp, color=continent, frame = year,group=continent))+
  geom_point(aes(ids = country))+
  scale_x_log10()+
  geom_smooth(method="lm")

ggplotly()


# Finally, a useful addition is facet_wrap, where it is possible to create many similar graphs with the one command. For example a plot for each continent.

gapminder %>% 
  ggplot(aes(x=gdpPercap, y=lifeExp, color=continent,,group=continent))+
  geom_point()+
  facet_wrap(~continent)

# facet_grid() can allow for a set of new variables by different parameters.
gapminder %>% 
  ggplot(aes(x=gdpPercap, y=lifeExp, color=continent,group=continent))+
  geom_point()+
  facet_grid(year~continent)

# It is also possible to plot several measurements on one graph. Then often you would have two y-axis, transforming them both into comparable ranges can be a bit tricky though. Visualization may not always be clear but it is sometimes done.
gapminder %>%
  filter(country=="France") %>%
  ggplot()+
  geom_point(aes(y=gdpPercap, x=year),color="green")+
  geom_point(aes(y=lifeExp, x=year),color="blue")



########################
# Task
# 3 countries in Europe, after 1970
# How life expectancy and gdp moved over time.
# Make it look nice.
########################

# Recap

# Basic features:
# ggplot() + layers

# Customize:
# scale transformations
# themes, guides

# Interactive
# plotly

