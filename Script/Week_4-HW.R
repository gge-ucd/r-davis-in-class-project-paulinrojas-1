library(tidyverse)

## 1
surveys <- read_csv('data/portal_data_joined.csv')
str(surveys)

spec(surveys)

## 2

surveys_Q2 <- surveys %>% filter(weight >30 & weight <60)
str(surveys_Q2)
head(surveys)
tibble(surveys_Q2)

## 3

biggest_critters <- surveys %>% filter(!is.na(weight)) %>% group_by(species_id, sex) %>% summarise(max_weight = max(weight))
head(biggest_critters)

##4
##Where the NA are concentrated in the data (species, taxa, plot, or whatever, where there are lots of NA values?
## use tally and arrage

?tally ()
surveys %>% filter(!is.na(weight)) %>% group_by(plot_id) %>% tally() %>% arrange(desc(n))

surveys %>% filter(!is.na(weight)) %>% group_by(species) %>% tally() %>% arrange(desc(n))                   

surveys %>% filter(!is.na(weight)) %>% group_by(taxa) %>% tally() %>% arrange(desc(n))                   

surveys %>% filter(!is.na(weight)) %>% group_by(year) %>% tally() %>% arrange(desc(n))

## Take surveys, remove the rows where weight is NA and add a column that contains the average weight of each species+sex combination to the full surveys dataframe. 
## Then get rid of all the columns except for species, sex, weight, and your new average weight column. 
## Save this tibble as surveys_avg_weight.

surveys_avg_weight <- surveys %>% filter(!is.na(weight)) %>% group_by(species_id, sex) %>% mutate(avg_weight = mean(weight)) %>% select(species_id, sex, weight, avg_weight)
head(surveys_avg_weight)
str(surveys_avg_weight)

##Take surveys_avg_weight and add a new column called above_average that contains logical values 
## stating whether or not a row’s weight is above average for its species+sex combination 
## (recall the new column we made for this tibble)

surveys_avg_weight <- surveys_avg_weight %>% mutate(above_avg = weight >avg_weight)
head(surveys_avg_weight)
