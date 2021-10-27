# Exercise: use pivot_longer to transform classroom2 into tidy format

classroom2 %>%
  pivot_longer(-assessment,
               names_to = "name",
               values_to = "grade"
  )

# Exercise: convert weather to tidy format using pivot_longer, names_pattern, and names_transform

weather %>%
  pivot_longer(
    d1:d31,
    names_to = "day",
    names_pattern = ".(.*)",
    names_transform = list(day=as.integer),
    values_to = "value",
    values_drop_na = TRUE
  )

# Exercise: convert tb to long format in one step using names_pattern

tb %>% pivot_longer(
  !c(iso2, year), 
  names_to = c("sex", "age"), 
  names_pattern = "(.)(.*)",
  values_to = "n",
  values_drop_na = TRUE
)

# Exercise: use pivot_long on anscombe so there is a column for set (1-4), and only one x and one y column

anscombe %>% 
  pivot_longer(x1:y4, # can also use everything()
               names_to = c(".value", "set"), 
               names_pattern = "(.)(.)"
  )

# Exercise: Create a tidy us_rent_income with "." as the separator, first using names_sep, then using names_glue

us_rent_income %>%
  pivot_wider(
    names_from = variable,
    names_sep = ".",
    values_from = c(estimate, moe)
  )

us_rent_income %>%
  pivot_wider(
    names_from = variable,
    names_glue = "{variable}_{.value}",
    values_from = c(estimate, moe)
  )

# Exercise: convert who to tidy format with columns diagnosis, gender, and age

who %>% pivot_longer(
  cols = new_sp_m014:newrel_f65,
  names_to = c("diagnosis", "gender", "age"), 
  names_pattern = "new_?(.*)_(.)(.*)",
  values_to = "count",
  values_drop_na=TRUE
)