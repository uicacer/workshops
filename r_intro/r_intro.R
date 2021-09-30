######################
## Introduction to R #
######################

download.file("https://raw.githubusercontent.com/uicacer/workshops/main/r_intro/r_intro.R", "r_intro.R")

################
## Arithmetic ##
################

# addition
4 + 5
# same code as above, without spaces
4+5

# subtraction
2 - 3
# multiplication
2 * 3
# division
2 / 3
# exponentiation
2 ^ 3

#####################
## Using functions ##
#####################

# using a function: rounding numbers
round(3.14)
# using a function with more arguments
round(3.14, digits = 1)
# can switch order of arguments
round(digits = 1, x = 3.14)

# getting help
?hist

# assigning value to an object
weight_kg <- 55
# recall object
weight_kg
# multiply an object (convert kg to lb)
2.2 * weight_kg
# assign weight conversion to object
weight_lb <- 2.2 * weight_kg
# reassign new value to an object
weight_kg <- 100
weight_kg

### EXERCISE ###
# Define a variable height_in and set it equal to 72
# Define another variable height_cm and set it equal to height_in times 2.54
################

#############
## Vectors ##
#############

# assign vector
ages <- c(50, 55, 60, 65) 
# recall vector
ages

# how many things are in object?
length(ages)
# what type of object?
class(ages)
# get overview of object
str(ages)

# performing functions with vectors
mean(ages)
range(ages)

# vector of body parts
organs <- c("lung", "kidney", "heart")

length(organs)
class(organs)
str(organs)

### EXERCISE ###
# What happens when we try to mix multiple types of data in a single vector?
################

# add a value to end of vector
ages <- c(ages, 90) 
print(ages)

# add value at the beginning
ages <- c(30, ages)
print(ages)

# extracting second value
organs[2] 
# excluding second value
organs[-2] 
# extracting first and third values
organs[c(1, 3)] 

# condition
ages > 60 
# extracts values which meet condition
ages[ages > 60] 
# extracts values numerically equivalent values
ages[ages == 60]
# ages less than 50 OR greater than 60
ages[ages < 50 | ages > 60]
# ages greater than 50 AND less than 60
ages[ages > 50 & ages < 60]

### EXERCISE ###
# Is it possible to apply more than two conditions at once?
# Try to select all ages that are less than 55 or between 59 and 64
################

### EXERCISE ###
# What does the following code return, and why?
"four" > "five"
################

##################
## Missing data ##
##################

# create a vector with missing data
heights <- c(2, 4, 4, NA, 6)

# calculate mean and max on vector with missing data
mean(heights)
max(heights)

# add argument to remove NA
mean(heights, na.rm = TRUE)
max(heights, na.rm = TRUE)

# identify elements which are missing data
is.na(heights)
# reverse the TRUE/FALSE
!is.na(heights)
# extract elements which are not missing values
heights[!is.na(heights)]
# remove incomplete cases
na.omit(heights)

### EXERCISE ###
# Complete the following tasks after creating this vector (Note: there are multiple solutions):
more_heights <- c(63, 69, 60, 65, NA, 68, 61, 70, 61, 59, 64, 69, 63, 63, NA, 72, 65, 64, 70, 63, 65)
# 1. Remove NAs
# 2. Calculate the median
# 3. Identify how many elements in the vector are greater than 67
################

#################
## Data frames ##
#################

# make a directory
dir.create("data")
# download data from url
download.file("https://raw.githubusercontent.com/uicacer/workshops/main/r_intro/data/animals.csv", "data/animals.csv")
# import data and assign to object
animals <- read.csv("data/animals.csv")
# assess size of data frame
dim(animals)
# preview first few rows
head(animals) 
# show last three rows
tail(animals, n = 3) 
# view column names
names(animals) 
# show overview of object
str(animals) 
# provide summary statistics for each column
summary(animals) 

# extract first column and assign to a variable
first_column <- animals[1]
head(first_column)

# extract first row 
first_row <- animals[1, ]
head(first_row)

# extract first column
first_column_again <- animals[ , 1]
head(first_column_again)

### EXERCISE ###
# What is the difference in results between the last two lines of code?
################

# extract cell from first row of first column
single_cell <- animals[1,1]
single_cell

# extract a range of cells, rows 1 to 3, second column
range_cells <- animals[1:3, 2]
range_cells

# exclude first column
exclude_col <- animals[ , -1] 
head(exclude_col)

# exclude first 100 rows
exclude_range <- animals[-c(1:100), ] 
head(exclude_range)

# extract column by name
name_col1 <- animals["taxa"]
head(name_col1)

name_col2 <- animals[ , "taxa"]
head(name_col2)

# double square brackets syntax
name_col3 <- animals[["taxa"]]
head(name_col3)

# dollar sign syntax
name_col4 <- animals$taxa
head(name_col4)

# Export the data with the first hundred rows excluded
write.csv(exclude_range, "data/animals_subset.csv")

# functions on columns
range(animals$weight, na.rm = TRUE)
mean(animals$weight, na.rm = TRUE)

### EXERCISES ###
# 1. Code as many different ways possible to extract the column “genus”
# 2. Extract the first 6 rows for only hindfoot length and species
# 3. Calculate the range and mean for weight
# 4. Create a data.frame (animals_200) containing only the data in row 200 of the animals dataset.
#################

#######################
## Data manipulation ##
#######################

# install package
install.packages("dplyr")
# load library/package
library(dplyr)

# selecting columns with dplyr
sel_columns <- select(animals, sex, weight, taxa)
head(sel_columns)

# select range of columns
sel_columns2 <- select(animals, sex:taxa)
head(sel_columns2)

# select columns to remove
sel_columns3 <- select(animals, -sex, -hindfoot_length)
head(sel_columns3)

# select rows conditionally: keep only rodents
filtered_rows <- filter(animals, taxa == "Rodent") 
head(filtered_rows)

### EXERCISE ###
# Create a new object from animals called sex_taxa that includes only the sex and taxa columns
################

### EXERCISE ###
# Create a new object from sex_taxa called sex_Rodent that includes only Rodent (taxa)
################

sex_taxa <- select(animals, sex, taxa)
sex_rodent <- filter(sex_taxa, taxa=="Rodent")
head(sex_rodent)

# nested select and filter
sex_rodent <- filter(select(animals, sex, taxa), taxa == "Rodent")
head(sex_rodent)

# same task as above, but with pipes
piped <- animals %>%
  select(sex, taxa) %>%
  filter(taxa == "Rodent")
head(piped)

# extract sex and weight from samples before 1995
piped2 <- animals %>%
  filter(year < 1995) %>%
  select(sex, weight)
head(piped2)

### EXERCISE ###
# Using pipes, subset the animals data to include animals under 5 grams
# collected before 1995, and retain only the columns year, sex, and weight.
################

# convert grams to kilograms
animals_kg <- animals %>%
  mutate(weight_kg = weight / 1000)
head(animals_kg)

# convert weight to kgs and lbs at same time, and we don't always need to assign to object
animals %>%
  mutate(weight_kg = weight / 1000,
         weight_lb = weight_kg * 2.2) %>%
  glimpse() # preview data output

### EXERCISE ###
# Create a new data frame from the surveys data that meets the following criteria:
# contains only the species column and a new column called hindfoot_cm
# containing the hindfoot_length values converted to centimeters.
# In this hindfoot_cm column, there are no NAs and all values are less than 3.
################

# show categories in sex
unique(animals$sex)

# replace "not reported" with NA
sex_na <- na_if(animals$sex, "not reported")
head(sex_na)

# update the data frame
animals <- animals %>%
  mutate(sex = na_if(sex, "not reported"))
head(animals)

# count number of individuals of each sex
animals %>%
  group_by(sex) %>%
  tally()

# summarize average weight and median hindfoot length by sex
animals %>%
  group_by(sex) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE),
            median_foot_length = median(hindfoot_length, na.rm = TRUE))

# remove NA
animals %>%
  filter(!is.na(sex)) %>%
  group_by(sex) %>%
  summarize(mean_weight = mean(weight, na.rm=TRUE))

### EXERCISE ###
# Use group_by() and summarize() to find the mean, min, and max hindfoot length for each species.
# Also add the number of observations (hint: see ?n).
################

### EXERCISE ###
# What was the heaviest animal measured in each year?
# Return the columns year, genus, species, and weight.
################

# counting number of records for each species
species_counts <- animals %>%
  count(species) %>%
  arrange(n)
head(species_counts)

# get names of frequently occurring species
frequent_species <- species_counts %>%
  filter(n >= 500)
head(frequent_species)

# extract data from species to keep
animals_reduced <- animals %>%
  filter(species %in% frequent_species$species)
head(animals_reduced)

# save results to file in data/ named animals_reduced
write.csv(animals_reduced, "data/animals_reduced.csv")

### EXERCISE ###
# Exercise: extract all species with more than 200 examples
################