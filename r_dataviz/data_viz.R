##### Data Visualization in R with ggplot #####


# tidyverse is a set of packages for working with data
# ggplot is a package within the tidyverse collection

# load tidyverse
library(tidyverse)

# load data in R
animals <- read_csv("data/animals.csv")


#### ggplot ####

# ggplot(data = <DATA>, mapping = aes(<MAPPINGS>)) +  <GEOM_FUNCTION>()

# bind the plot to a dataframe
ggplot(data = animals)

# define aesthetic mapping by selecting x & y
ggplot(data = animals, mapping = aes(x = weight, y = hindfoot_length))

# add "geom" aka graphical representation of data
# common geoms:
# - geom_point() for scatterplots, dot plots etc.
# - geom_boxplot() for boxplots
# - geom_line() for trend lines, time series

# add a goem with the plus operator
ggplot(data = animals, aes(x = weight, y = hindfoot_length)) +
  geom_point()

# An option for exploring many plots
animals_plot <- ggplot(data = animals,
                       mapping = aes(x = weight, y = hindfoot_length))

# draw the plot
animals_plot + 
  geom_point()

# This is the correct syntax for adding layers
animals_plot +
  geom_point()

# This will not add the new layer and will return an error message
animals_plot
+ geom_point()

## Excercise

# Install hexbin for a different plot type

install.packages("hexbin")

library(hexbin)

animals_plot + geom_hex()


## Build plots iteratively ##

ggplot(data = animals, aes(x = weight, y = hindfoot_length)) +
  geom_point()

# modification to transparency

ggplot(data = animals, aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.1)

# modification to color

ggplot(data = animals, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.1, color = "blue")

# color by species

ggplot(data = animals, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.1, aes(color = species_id))


## Boxplot ##

ggplot(data = animals, mapping = aes(x = species_id, y = weight)) +
  geom_boxplot()

# add points

ggplot(data = animals, mapping = aes(x = species_id, y = weight)) +
  geom_boxplot(alpha = 0) +
  geom_jitter(alpha = 0.3, color = "tomato")


## Time Series Data ##

# Calculate # of counts per year for each genus
yearly_counts <- animals %>%
  count(year, genus)

# create time series

ggplot(data = yearly_counts, aes(x = year, y = n)) +
  geom_line()

# line for each genus

ggplot(data = yearly_counts, aes(x = year, y = n, group = genus)) +
  geom_line()

# add color for lines

ggplot(data = yearly_counts, aes(x = year, y = n, color = genus)) +
  geom_line()


## Using the pipe operator with ggplot ##

yearly_counts %>%
  ggplot(mapping = aes(x = year, y = n, color = genus)) +
  geom_line()

# pipe data manipulation to visualization

yearly_counts_graph <- animals %>%
  count(year, genus) %>%
  ggplot(mapping = aes(x = year, y = n, color = genus)) +
  geom_line()

yearly_counts_graph

## Faceting ##

ggplot(data = yearly_counts, aes(x = year, y = n)) +
  geom_line() +
  facet_wrap(facets = vars(genus))

# split the line by sex

yearly_sex_counts <- animals %>%
  count(year, genus, sex)

ggplot(data = yearly_sex_counts, mapping = aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_wrap(facets =  vars(genus))

# facet by sex and genus

ggplot(data = yearly_sex_counts,
       mapping = aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_grid(rows = vars(sex), cols =  vars(genus))

# organize panels by only rows (or cols)

# One column, facet by rows
ggplot(data = yearly_sex_counts,
       mapping = aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_grid(rows = vars(genus))

# One row, facet by column
ggplot(data = yearly_sex_counts,
       mapping = aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_grid(cols = vars(genus))

#### ggplot themes ####

ggplot(data = yearly_sex_counts,
       mapping = aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_wrap(vars(genus)) +
  theme_bw()

#### Customization ####

# change axis labels

ggplot(data = yearly_sex_counts, aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_wrap(vars(genus)) +
  labs(title = "Observed genera through time",
       x = "Year of observation",
       y = "Number of individuals") +
  theme_bw()

# increase font size

ggplot(data = yearly_sex_counts, mapping = aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_wrap(vars(genus)) +
  labs(title = "Observed genera through time",
       x = "Year of observation",
       y = "Number of individuals") +
  theme_bw() +
  theme(text=element_text(size = 16))

# more customization

ggplot(data = yearly_sex_counts, mapping = aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_wrap(vars(genus)) +
  labs(title = "Observed genera through time",
       x = "Year of observation",
       y = "Number of individuals") +
  theme_bw() +
  theme(axis.text.x = element_text(colour = "grey20", size = 12, angle = 90, hjust = 0.5, vjust = 0.5),
        axis.text.y = element_text(colour = "grey20", size = 12),
        strip.text = element_text(face = "italic"),
        text = element_text(size = 16))

# create your own theme

grey_theme <- theme(axis.text.x = element_text(colour="grey20", size = 12,
                                               angle = 90, hjust = 0.5,
                                               vjust = 0.5),
                    axis.text.y = element_text(colour = "grey20", size = 12),
                    text=element_text(size = 16))

ggplot(surveys_complete, aes(x = species_id, y = hindfoot_length)) +
  geom_boxplot() +
  grey_theme


#### Arranging plots ####

install.packages("patchwork")

library(patchwork)

plot_weight <- ggplot(data = animals, aes(x = species_id, y = weight)) +
  geom_boxplot() +
  labs(x = "Species", y = expression(log[10](Weight))) +
  scale_y_log10()

plot_count <- ggplot(data = yearly_counts, aes(x = year, y = n, color = genus)) +
  geom_line() +
  labs(x = "Year", y = "Abundance")

plot_weight / plot_count + plot_layout(heights = c(3, 2))

# Exporting plots

my_plot <- ggplot(data = yearly_sex_counts,
                  aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_wrap(vars(genus)) +
  labs(title = "Observed genera through time",
       x = "Year of observation",
       y = "Number of individuals") +
  theme_bw() +
  theme(axis.text.x = element_text(colour = "grey20", size = 12, angle = 90,
                                   hjust = 0.5, vjust = 0.5),
        axis.text.y = element_text(colour = "grey20", size = 12),
        text = element_text(size = 16))

ggsave("name_of_file.png", my_plot, width = 15, height = 10)

## This also works for plots combined with patchwork
plot_combined <- plot_weight / plot_count + plot_layout(heights = c(3, 2))
ggsave("plot_combined.png", plot_combined, width = 10, dpi = 300)
