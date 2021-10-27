library(dplyr)
library(tidyr)

classroom <- as_tibble(read.csv("https://raw.githubusercontent.com/tidyverse/tidyr/master/vignettes/classroom.csv", stringsAsFactors = FALSE))
classroom2 <- (read.csv("https://raw.githubusercontent.com/tidyverse/tidyr/master/vignettes/classroom2.csv", stringsAsFactors = FALSE, colClasses = c("Suzy"="character")))

classroom

classroom2

# pivot_longer

pivot_longer(data, cols, names_to, values_to)

# Column headers are values, not variable names.

pivot_longer(classroom, quiz1:test1, names_to = "assessment", values_to = "grade")

# use pipe for easier reading
classroom %>%
  pivot_longer(quiz1:test1,
               names_to = "assessment",
               values_to = "grade"
  )

# can use c() to select columns
classroom %>%
  pivot_longer(c(quiz1, quiz2, test1),
               names_to = "assessment",
               values_to = "grade"
  )

# can use - to select columns to ignore instead of selecting columns to include
classroom %>%
  pivot_longer(-name,
               names_to = "assessment",
               values_to = "grade"
  )

# can use values_drop_na to leave out rows that would have missing values
classroom %>%
  pivot_longer(-name,
               names_to = "assessment",
               values_to = "grade",
               values_drop_na = TRUE
  )

# Exercise: use pivot_longer to transform classroom2 into tidy format

classroom2

# Modifying column names

billboard

billboard2 <- billboard %>% 
  pivot_longer(
    wk1:wk76, 
    names_to = "week", 
    values_to = "rank", 
    values_drop_na = TRUE
  )
billboard2

billboard3 <- billboard2 %>%
  mutate(
    week = as.integer(gsub("wk", "", week))
  )
billboard3

billboard %>%
  pivot_longer(
    wk1:wk76,
    names_to = "week",
    names_pattern = "wk(.+)",
    names_transform = list(week=as.integer),
    values_to = "rank",
    values_drop_na = TRUE
  )

# Regular expression tutorial: https://regexone.com/

weather <- as_tibble(read.csv('https://raw.githubusercontent.com/tidyverse/tidyr/master/vignettes/weather.csv', stringsAsFactors = FALSE))
weather

# Exercise: convert weather to tidy format using pivot_longer, names_pattern, and names_transform

weather

# Multiple variables are stored in one column.

tb <- as_tibble(read.csv("https://raw.githubusercontent.com/tidyverse/tidyr/master/vignettes/tb.csv", stringsAsFactors = FALSE))
tb

tb2 <- tb %>% 
  pivot_longer(
    !c(iso2, year), 
    names_to = "demo", 
    values_to = "n", 
    values_drop_na = TRUE
  )
tb2

tb3 <- tb2 %>% 
  separate(demo, c("sex", "age"), 1)
tb3

# Exercise: convert tb to long format in one step using names_pattern

tb

# keep part of column name with .value

family <- tribble(
  ~family,  ~dob_child1,  ~dob_child2, ~gender_child1, ~gender_child2,
  1L, "1998-11-26", "2000-01-29",             1L,             2L,
  2L, "1996-06-22",           NA,             2L,             NA,
  3L, "2002-07-11", "2004-04-05",             2L,             2L,
  4L, "2004-10-10", "2009-08-27",             1L,             1L,
  5L, "2000-12-05", "2005-02-28",             2L,             1L,
)

family %>% 
  pivot_longer(
    !family, 
    names_to = c(".value", "child"), 
    names_sep = "_", 
    values_drop_na = TRUE
  )

family %>% 
  pivot_longer(
    !family, 
    names_to = c(".value", "child"), 
    names_pattern = "(.*)_child(.*)",
    names_transform = as.integer,
    values_drop_na = TRUE
  )

anscombe

# Exercise: use pivot_long on anscombe so there is a column for set (1-4), and only one x and one y column

anscombe

# pivot_wider

fish_encounters

fish_encounters %>%
  pivot_wider(names_from = station, values_from = seen)

fish_encounters %>% pivot_wider(
  names_from = station, 
  values_from = seen,
  values_fill = 0
)

# pivot wider with multiple columns

production <- expand_grid(
  product = c("A", "B"), 
  country = c("AI", "EI"), 
  year = 2000:2014
) %>%
  filter((product == "A" & country == "AI") | product == "B") %>% 
  mutate(production = rnorm(nrow(.)))
production

production %>% pivot_wider(
  names_from = c(product, country), 
  values_from = production
)

production %>% pivot_wider(
  names_from = c(product, country), 
  values_from = production,
  names_sep = ".",
  names_prefix = "prod."
)

production %>% pivot_wider(
  names_from = c(product, country), 
  values_from = production,
  names_glue = "prod_{product}_{country}"
)

us_rent_income

us_rent_income %>% 
  pivot_wider(names_from = variable, values_from = c(estimate, moe))

# Exercise: Create a tidy us_rent_income with "." as the separator, first using names_sep, then using names_glue

us_rent_income

# Exercise: convert who to tidy format with columns diagnosis, gender, and age

who

# country, iso2, iso3, and year are already variables, so they can be left as is. But the columns from new_sp_m014 to newrel_f65 encode four variables in their names:

# The new_/new prefix indicates these are counts of new cases. This dataset only contains new cases, so we’ll ignore it here because it’s constant.

# ep/sn/sp/rel describe how the case was diagnosed.

# m/f gives the gender.

# 014/1524/2535/3544/4554/65 supplies the age range.