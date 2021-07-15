##########
# Set up #
##########

library(ggplot2)
library(dplyr)
library(tidyr)
library(ggthemes)

# ensure we use a colorblind accessible palette
scale_fill_discrete <- scale_fill_colorblind
scale_colour_discrete <- scale_color_colorblind

# data sets to use later
anscombe_tidy <- anscombe %>%
  pivot_longer(cols = everything(),
               names_to = c(".value", "set"),
               names_pattern = "(.)(.)") %>%
  mutate(set = as.character(as.roman(set)))

airline <- data.frame(passengers=as.matrix(AirPassengers),
                      month=factor(month.abb[cycle(AirPassengers)], levels=month.abb),
                      year=as.vector(floor(time(AirPassengers))),
                      date=as.vector(time(AirPassengers)))

#################
# Scatter plots #
#################

# basic scatter plot
p <- ggplot(mtcars, aes(x=wt, y=mpg))
p
p + geom_point()

# customize appearance
p + geom_point(color="red")
p + geom_point(size=2)
p + geom_point(shape="square", color="blue", size=4)

# use color/shape/size as encodings
p + geom_point(aes(color = gear))
p + geom_point(aes(color = factor(gear)))
p + geom_point(aes(shape = factor(gear)))
p + geom_point(aes(size = gear))

# EXERCISES
# 1a. Scatterplot of Anscombe's Quartet
# 1b. Scatterplot of Anscombe's Quartet with orange triangles
# 1c. Scatterplot of Anscombe's Quartet with shape and color based on set

############
# Faceting #
############

# scatterplot of fuel efficiency by weight
p <- ggplot(mtcars, aes(x=wt, y=mpg))

# facet by gear
p + geom_point() +
  facet_wrap(~gear)

# facet and color by gear
p + geom_point(aes(color=factor(gear))) +
  facet_wrap(~gear)

# EXERCISE
# 2. Scatterplot of Anscombe's Quartet faceted by set

###############
# Line graphs #
###############

# basic line graph
p <- ggplot(airline, aes(x=date, y=passengers))
p + geom_line()

# customize line type
p + geom_line(linetype="dashed")
p + geom_line(linetype="dotted")

# EXERCISE
# 3. Line graph of airline passengers by year faceted by month

##############
# Bar graphs #
##############

# bar graph count
ggplot(mtcars, aes(x=factor(gear))) + geom_bar()
ggplot(mtcars, aes(x=factor(gear))) + geom_bar(aes(fill=factor(gear)))

# bar graph mean
ggplot(mtcars, aes(x=factor(gear), y=wt)) +
  geom_bar(stat="summary", fun="mean", aes(fill=factor(gear)))

# EXERCISE
# 4a. Bar graph of counts for each num of cylinders colored by num of cylinders
# 4b. Bar graph of average airline passengers for each month

####################
# Regression lines #
####################

p <- ggplot(airline, aes(x=date, y=passengers)) + geom_line()

# linear regression
p + geom_smooth(method="lm")
# remove standard error shading
p + geom_smooth(method="lm", se=FALSE)
# add a degree two polynomial to the model
p + geom_smooth(method="lm", se=FALSE, formula="y~poly(x,2)")

# LOESS (locally estimated scatterplot smoothing)
p + geom_smooth(method="loess", se=FALSE)
# decrease span to allow for more wiggly lines
p + geom_smooth(method="loess", se=FALSE, span=0.1)

#####################
# Labels and titles #
#####################

ggplot(mtcars, aes(x=wt, y=mpg, color=factor(gear))) +
  geom_point() +
  xlab('weight') +
  ylab('miles per galon') +
  ggtitle('Fuel efficiency by weight') +
  # because the legend is for color, we set the legend title using 'color'
  labs(color='gears')

# EXERCISE
# 5. Scatterplot of Anscombe's Quartet faceted by set, red points,
# darkblue linear regression line, x-axis "independent variable",
# y-axis "dependent variable", title "Anscombe's Quartet"

#####################
# Polar coordinates #
#####################

# original bar chart
ggplot(mtcars, aes(x=factor(gear))) + geom_bar()

# stacked bar chart
ggplot(mtcars, aes(x="", fill=factor(gear))) + geom_bar()

# pie chart
ggplot(mtcars, aes(x="", fill=factor(gear))) + geom_bar() +
  coord_polar(theta="y")

# bullseye plot
ggplot(mtcars, aes(x="", fill=factor(gear))) +
  # set width to 1 to avoid gap
  geom_bar(width=1) +
  coord_polar(theta="x")

# coxcomb plot
ggplot(mtcars, aes(x=factor(gear), fill=factor(gear))) +
  geom_bar(width=1) +
  coord_polar(theta="x")