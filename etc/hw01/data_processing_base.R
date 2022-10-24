library(gapminder)
library(dplyr)
glimpse(gapminder)

# select
gapminder[, c("country", "lifeExp", "year")]

# filter
gapminder[1:15, ]
gapminder[gapminder$country == "Croatia", ]

# select + filter
gapminder[gapminder$country == "Croatia", "pop"]
gapminder[gapminder$country == "Croatia", c("lifeExp", "pop")]

# 논리연산자로 조건식 결합
gapminder[gapminder$country == "Croatia" & gapminder$year > 1990, c("lifeExp", "pop")]

# apply
apply(gapminder[gapminder$country == "Croatia", c("lifeExp", "pop")], 2, mean)
