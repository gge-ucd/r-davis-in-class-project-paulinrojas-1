library(tidyverse)
gapminder <- read_csv('https://gge-ucd.github.io/R-DAVIS/data/gapminder.csv') %>% 
  filter(complete.cases(.))

str(gapminder)

# 1 First calculates mean life expectancy on each continent. 
# Then create a plot that shows how life expectancy has changed over time in each continent. 
#Try to do this all in one step using pipes! (aka, try not to create intermediate dataframes)

gapminder %>% mutate(mean(lifeExp))
str(gapminder)

ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = gapminder$lifeExp)) + 
  geom_point(mapping = aes(color = continent, size = .01)) 

ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = gapminder$lifeExp)) + 
  geom_point(mapping = aes(color = continent, size = .005)) +
  scale_x_log10() +  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()

gapminder %>%
  group_by(continent, year) %>% summarize(mean_lifeExp = mean(lifeExp)) %>% ggplot()+
  geom_point(aes(x = year, y = mean_lifeExp, color = continent))+ geom_line(aes(x = year, y = mean_lifeExp, color = continent))


#2 Look at the following code and answer the following questions. 
#What do you think the scale_x_log10() line of code is achieving? 
#What about the geom_smooth() line of code?

#scale_x_log10()  tranform my data before ploting it
# geom_smooth() add a line to indicate tendency

#Challenge! Modify the above code to size the points in proportion to the population of the country. 
#Hint: Are you translating data to a visual feature of the plot?

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) + geom_point(aes(color = continent, size = pop)) + 
  scale_x_log10() + geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') + theme_bw()

##3 Create a boxplot that shows the life expectency for Brazil, China, El Salvador, Niger, and the United States, 
#with the data points in the backgroud using geom_jitter. 
#Label the X and Y axis with “Country” and “Life Expectancy” and title the plot “Life Expectancy of Five Countries”.

countries <- c("Brazil", "China", "El Salvador", "Niger", "United States")
str(countries)

gapminder %>% filter(country %in% countries) %>% ggplot(aes(x = country, y = lifeExp))+
  geom_boxplot() + geom_jitter(alpha = 0.3, color = "blue")+ theme_minimal() + ggtitle ("Life Expentancy of Five Countries")

