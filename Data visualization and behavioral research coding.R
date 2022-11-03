# Set working directory
setwd("C:/Users/DavidBinder/Documents/Personal/BSB/Behavioral tools/Data visualization and behavioral research")
# update packages
# update.packages(ask = FALSE)
# install.packages("rlang")

# Import libraries
library(ggplot2)
library(tidyverse)
library(forcats)

# Load the data (creates data frame df)
load("Data set 1.rdata")

# Exercise 1 - Create the scatter plot
p = ggplot(df, aes(x = my_x, y = my_y)) +
  geom_point()
p

# Exercise 2 - Create the line graph
p = ggplot(df, aes(x = my_x, y = my_y)) +
  geom_line()
p

# shade in area
p = ggplot(df, aes(x = my_x, y = my_y)) +
  geom_area() +
  geom_point()
p

# Exercise 3 - Create the line graph with markers
p = ggplot(df, aes(x = my_x, y = my_y)) +
  geom_point() +
  geom_line()
p

# Exercise 4 - Try to use geom_bar (first attempt not correct)

# Load the data - creates data frame ls
load("Life satisfaction.rdata")

ls = filter(ls, g7 == 1)
p = ggplot(ls, aes(x = country)) +
  geom_bar()
p

# Exercise 5 - use geom_bar to get mean and max life satisfaction by country
# bar graph with mean life satisfaction on y-axis
p = ggplot(ls, aes(x = country, y = life_satisf)) +
  geom_bar(stat = "summary", fun = "mean")
p

# bar graph with max life satisfaction on y-axis
p = ggplot(ls, aes(x = country, y = life_satisf)) +
  geom_bar(stat = "summary", fun = "max")
p

# Exercise 6 - using geom_col
# bar graph with average life satisfaction for 2020 on y-axis  
ls = filter(ls, g7 == 1 & year == 2020)
p = ggplot(ls, aes(x = country, y = life_satisf)) +
  geom_col()
p

# equivalent using geom_bar
p = ggplot(ls, aes(x = country, y = life_satisf)) +
  geom_bar(stat = "identity")
p


# Exercise 7 - grouped column, stacked column, stacked 100% column
load("Life satisfaction by group.rdata")

# grouped column
lsgrp = filter(lsgrp, life_satisf_grp == 'LOW' | life_satisf_grp == 'MED')
p = ggplot(lsgrp, aes(x = country, y = percentage, fill = life_satisf_grp)) +
  geom_col(position = "dodge")
p

# stacked column
p = ggplot(lsgrp, aes(x = country, y = percentage, fill = life_satisf_grp)) +
  geom_col(position = "stack")
p

# stacked 100% column
p = ggplot(lsgrp, aes(x = country, y = percentage, fill = life_satisf_grp)) +
  geom_col(position = "fill")
p

# examples on slides 24 and 25
# load("Data set 1.Rdata")
# df
# p = ggplot(df, aes(x = country, y = my_y, fill = category)) +
#   geom_col(position = "dodge")
# p
# df
# p = ggplot(df, aes(x = country, y = my_y, fill = category)) +
#   geom_col(position = "stack")
# p
# p = ggplot(df, aes(x = country, y = my_y, fill = category)) +
#   geom_col(position = "fill")
# p


# Exercise 8 - x-axis and y-axis adjustments
load("Life satisfaction.rdata")

# using ylim - works
p = ggplot(ls, aes(x = gdp_cap, y = life_satisf)) +
  geom_point() +
  ylim(c(0, 10)) +
  scale_x_continuous(breaks = seq(0, 100000, 25000), 
                     labels = c('Nul', 'Low', 'lower Middle', 'Upper Middle', 'High')) +
  theme(axis.text.x = element_text(angle = 90, hjust = 0.5, vjust = 0.5))
p

# variant using coord_cartesian - works
p = ggplot(ls, aes(x = gdp_cap, y = life_satisf)) +
  geom_point() +
  coord_cartesian(ylim = c(0, 10)) +
  scale_x_continuous(breaks = seq(0, 100000, 25000), 
                     labels = c('Nul', 'Low', 'lower Middle', 'Upper Middle', 'High')) +
  theme(axis.text.x = element_text(angle = 90, hjust = 0.5, vjust = 0.5))
p

# variant using scale_y_continuous with limits (using breaks didn't work)
p = ggplot(ls, aes(x = gdp_cap, y = life_satisf)) +
  geom_point() +
  scale_x_continuous(breaks = seq(0, 100000, 25000),
                     labels = c('Nul', 'Low', 'lower Middle', 'Upper Middle', 'High')) +
  #  scale_y_continuous(breaks = seq(0, 10, 2.5), limits = c(0, 10)) + [more generic solution to control break]
  scale_y_continuous(limits = c(0, 10)) +
  theme(axis.text.x = element_text(angle = 90, hjust = 0.5, vjust = 0.5))
p

# Exercise 9: Reproduce the following plot with “Life satisfaction.RData ” and for the year 2015

# Load the data - creates data frame ls
load("Life satisfaction.rdata")

ls = filter(ls, year == 2015)
p = ggplot(ls, aes(x = gdp_cap, y = life_satisf)) +
  geom_point(aes(col = continent, size = pop), alpha = 0.5) +
  scale_size("Population",
    breaks = c(330237, 5565283, 11432096, 35572269, 1406847868)
  ) +
  guides(size = guide_legend(order = 1), col = guide_legend(order = 2))
p

# Exercise 10: Reproduce the following plot with “Life satisfaction.RData

# Load the data - creates data frame ls
load("Life satisfaction.rdata")

ls = filter(ls, year == 2015)
p = ggplot(ls, aes(x = gdp_cap, y = life_satisf)) +
  geom_point(aes(col = continent)) +
  geom_smooth() +
  labs(
    title="Life satisfaction increases with GDP/cap until $70,000, then decreases",
    subtitle="Life satisfaction VS GDP per capita, 2015",
    y="Life satisfaction (0=worst life possible; 10: best life possible",
    x="GDP per capita",
    color = "Region",
    caption="Our World in Data"
  )
p

# Exercise 11: Reproduce the following plot with “Life satisfaction.RData

# Load the data - creates data frame ls
load("Life satisfaction.rdata")

ls = filter(ls, year == 2015)
p = ggplot(ls, aes(x = gdp_cap, y = life_satisf)) +
  geom_point(aes(col = continent)) +
  geom_smooth() +
  labs(
    color = "Region"
  ) +
  theme(panel.background = element_blank(),
        axis.line = element_line(),
        axis.title.x = element_text(face = "italic"),
        legend.position = "top",
        legend.title = element_blank(),
        legend.key = element_blank())
p

# Exercise 12: Reproduce the following plot with “Life satisfaction.RData

# Load the data - creates data frame ls
load("Life satisfaction.rdata")
ls = filter(ls, continent == "South America")

p = ggplot(ls, aes(x = year, y = gdp_cap)) +
  geom_line() +
  facet_wrap(~country)
p

# Exercise 13: Reproduce the following plot with “Life satisfaction.RData" and for year 2015

# Load the data - creates data frame ls
load("Life satisfaction.rdata")
ls = filter(ls, continent == "South America" & year == 2015)
ls$country = fct_reorder(ls$country, ls$life_satisf)

p = ggplot(ls, aes(x = country, y = life_satisf)) +
  geom_col() 
p

# Exercise 14: Produce a map showing LS in 2015

# Load the data - creates data frame ls
library("maps")

load("Life satisfaction.rdata")
ls = filter(ls, year == 2015)

world_map = map_data("world")

# update countries in ls to match countries in world_map data

ls_clean = ls %>%
  select(region = country, life_satisf)

ls_clean[ls_clean$region == "United Kingdom",]$region = "UK"
ls_clean[ls_clean$region == "United States",]$region = "USA"
ls_clean[ls_clean$region == "Democratic Republic of Congo",]$region = "Democratic Republic of the Congo"
ls_clean[ls_clean$region == "Congo",]$region = "Republic of Congo"
ls_clean[ls_clean$region == "Cote d'Ivoire",]$region = "Ivory Coast"
ls_clean[ls_clean$region == "Czechia",]$region = "Czech Republic"

ls_map = left_join(world_map, ls_clean, by = "region")

p = ggplot(ls_map, aes(x = long, y = lat, group = group)) +
  geom_polygon(aes(fill = life_satisf), color = "white") +
  theme(legend.position = "right",
        legend.title = element_blank(),
        legend.key = element_blank()) +
  scale_x_continuous(breaks = seq(-150, 150, 30)) +
  scale_y_continuous(breaks = c(-60, -30, 0, 30, 60)) +
  labs(
    title="Life satisfaction is lowest in Africa and Asia",
    subtitle="Life satisfaction by country, 2015",
    y="Latitude",
    x="Longitude",
    color = "Life satisfaction",
    caption="Source: World Facts R Us"
  )
p
