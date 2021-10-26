library(tidyverse)
read.csv("data/portal_data_joined.csv")
# Question 1
## create a new dataframe called surveys_wide with a column for genus and a column named after every plot type, 
# with each of these columns containing the mean hindfoot length of animals in that plot type and genus.
#dataframe should be sorted by values in the Control plot type column.

str(surveys)

surveys_wide <- surveys %>% filter(!is.na(hindfoot_length)) %>% group_by(genus, plot_type) %>% summarise(mean_hindfoot = mean(hindfoot_length)) %>%  pivot_wider(names_from = plot_type, values_from = mean_hindfoot) %>% arrange(Control)
surveys_wide

head(surveys_wide)
str(surveys_wide)


## Question 2
# Using the original surveys dataframe, use the two different functions we laid out for conditional statements, ifelse() and case_when(), 
#to calculate: a new weight category variable called weight_cat
#For this variable, rodent weight into three categories: “small” is < or equal to the 1st quartile of weight
#“medium” is between (but not inclusive) the 1st and 3rd quartile, and “large” is any weight greater than or equal to the 3rd quartile. 
# (Hint: the summary() function on a column summarizes the distribution)

# For ifelse() and case_when(), compare what happens to the weight values of NA, 
# depending on how you specify your arguments.


summary(surveys$weight)
surveys %>%  mutate(weight_cat = case_when(weight >= 20.00 ~ "small", weight > 20.00 & weight < 48.00 ~ 'Medium', weight >= 48.00 ~ 'large'))
# including NAs
surveys %>%  mutate(weight_cat = ifelse(weight >= 20.00, "small", ifelse(weight > 20.00 & weight < 48.00, 'Medium','large')))
#not inclluding NAs 

#BONUS: How might you soft code the values (i.e. not type them in manually) of the 1st and 3rd quartile 
#into your conditional statements in question 2?

summ <- summary(surveys$weight)
summ[[2]]
summ [[5]]

surveys %>%  mutate(weight_cat = case_when(weight >= summ[[2]] ~ "small", weight > summ[[2]] & weight < summ[[5]] ~ 'Medium', weight >= summ[[5]] ~ 'large'))
