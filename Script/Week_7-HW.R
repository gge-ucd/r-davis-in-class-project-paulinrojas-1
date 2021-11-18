library(tidyverse)
library(ggthemes)
gapminder <- read.csv('https://gge-ucd.github.io/R-DAVIS/data/gapminder.csv')

pg <- gapminder %>% select(country, year, pop, continent) %>% filter(year > 2000) %>% 
  pivot_wider(names_from = year, values_from = pop) %>% mutate(pop_change_0207 = '2007-2002')
 str(pg)
head(pg) 

pg %>% filter(continent == 'Oceania') %>% ggplot(aes(x=reorder(country, pop_change_0207), y = pop_change_0207)) + 
  geom_col(aes(fill = continent)) + facet_wrap(~continent, scales = 'free') + theme_bw() + scale_fill_viridis_d() + theme(axis.text.x = element_text(angle = 45, hjust = 1), legend.position = 'none') + 
  xlab('Country') + ylab('Change in Population Between 2002 and 2007')

