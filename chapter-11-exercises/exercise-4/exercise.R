# Exercise 4: practicing with dplyr

# Install the `"nycflights13"` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
install.packages("nycflights13")
library(nycflights13)

# The data frame `flights` should now be accessible to you.
# Use functions to inspect it: how many rows and columns does it have?

nrow(flights)
# 336776 rows are in the data set

ncol(flights)
# 19 columns are in the data set

# What are the names of the columns?
colnames(flights)

# Use `??flights` to search for documentation on the data set (for what the 
# columns represent)
?flights


# Use `dplyr` to give the data frame a new column that is the amount of time
# gained or lost while flying (that is: how much of the delay arriving occured
# during flight, as opposed to before departing).
gained_or_lost <- mutate(flights, gain_in_air = arr_delay - dep_delay)



# Use `dplyr` to sort your data frame in descending order by the column you just
# created. Remember to save this as a variable (or in the same one!)
gained_or_lost <- arrange(flights, desc(gain_in_air))
View(gained_or_lost)

# For practice, repeat the last 2 steps in a single statement using the pipe
# operator. You can clear your environmental variables to "reset" the data frame
gained_or_lost <- gained_or_lost %>% 
  mutate(gain_in_air = arr_delay - dep_delay) %>% 
  arrange(desc(gain_in_air))


# Make a histogram of the amount of time gained using the `hist()` function
hist(flights$gain_in_air)


# On average, did flights gain or lose time?
# Note: use the `na.rm = TRUE` argument to remove NA values from your aggregation
mean(gained_or_lost$gain_in_air, na.rm = TRUE)


# Create a data.frame of flights headed to SeaTac ('SEA'), only including the
# origin, destination, and the "gain_in_air" column you just created
SeaTac_flights <- gained_or_lost %>% 
  select(origin, dest, gain_in_air) %>% 
  filter(dest == "SEA")


# On average, did flights to SeaTac gain or loose time?
mean(SeaTac_flights$gain_in_air, na.rm = TRUE)

#Gained 11 minutes


# Consider flights from JFK to SEA. What was the average, min, and max air time
# of those flights? Bonus: use pipes to answer this question in one statement
# (without showing any other data)!
filter(gained_or_lost, origin == "JFK", dest == "SEA") %>%
  summarize(
    avg_air_time = mean(air_time, na.rm = TRUE), max_air_time = max(air_time, na.rm = TRUE), min_air_time = min(air_time, na.rm = TRUE)
  )
