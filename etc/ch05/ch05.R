select(gapminder, country, year, lifeExp)
filter(gapminder, country=="Croatia" & year >1990)

summarise(gapminder, mean(pop))
summarise(gapminder, pop_avg=mean(pop))
summarise(gapminder, life_min=min(lifeExp))
summarise(gapminder, count=n())

summarise(group_by(gapminder, continent), pop_avg=mean(pop))
summarise(group_by(gapminder, continent), n=n())

summarise(group_by(gapminder, continent, country), pop_avg=mean(pop))

gapminder %>% group_by(continent, country) %>% summarise(pop_avg=mean(pop))

temp1 = filter(gapminder, country=='Croatia')
temp2 = select(temp1, lifeExp, pop)
temp3 = apply(temp2[, c('lifeExp', 'pop')], 2, mean)
temp3

gapminder %>%
  filter(country=='Croatia') %>%
  select(lifeExp, pop) %>%
  summarise(lifeExp_avg=mean(lifeExp), pop_avg=mean(pop))

str(midwest)
View(midwest)

# midwest 예제
midwest %>%
  filter(poptotal >= 100000) %>%
  select(county, state, poptotal, popasian) %>%
  group_by(state) %>%
  summarise(n=n(), ratio_asian=mean(popasian/poptotal))


