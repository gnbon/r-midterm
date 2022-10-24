# 01 ������ �ð�ȭ��? #

# ���
apply(anscombe, 2, mean)

# �л�
apply(anscombe, 2, var)


# �������(������)
cor(anscombe$x1, anscombe$y1)

cor(anscombe$x2, anscombe$y2)

cor(anscombe$x3, anscombe$y3)

cor(anscombe$x4, anscombe$y4)

library(gapminder)
library(dplyr)
y <- gapminder %>% group_by(year, continent) %>% summarize(c_pop = sum(pop)) 
head(y, 20)

plot(y$year, y$c_pop)
plot(y$year, y$c_pop, col = y$continent)
plot(y$year, y$c_pop, col = y$continent, pch = c(1:5))
plot(y$year, y$c_pop, col = y$continent, pch = c(1:length(levels(y$continent))))

# ���� ������ ���ڷ� ����
legend("topleft", legend = 5, pch = c(1:5), col = c(1:5)) 

# ���� ������ ������ ������ �°� ����
legend("topleft", legend = levels((y$continent)), pch = c(1:length(levels(y$continent))), col = c(1:length(levels(y$continent))))


# 02 �ð�ȭ�� �⺻ ��� #
plot(gapminder$gdpPercap, gapminder$lifeExp, col = gapminder$continent)
legend("bottomright", legend = levels((gapminder$continent)), pch = c(1:length(levels(gapminder$continent))), col = c(1:length(levels(y$continent))))

plot(log10(gapminder$gdpPercap), gapminder$lifeExp, col = gapminder$continent)
legend("bottomright", legend  = levels((gapminder$continent)), pch = c(1:length(levels(gapminder$continent))), col = c(1:length(levels(y$continent))))

install.packages("ggplot2")
library(ggplot2)
ggplot(gapminder, aes(x =  gdpPercap, y = lifeExp, col = continent)) + geom_point() + scale_x_log10()

ggplot(gapminder, aes(x =  gdpPercap, y = lifeExp, col = continent, size = pop)) + geom_point() + scale_x_log10()

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp, col = continent, size = pop)) + geom_point(alpha = 0.5) + scale_x_log10()

ggplot(gapminder, aes(x=gdpPercap, y=lifeExp, col=continent, size=pop)) + geom_point(alpha=0.5) + scale_x_log10() + facet_wrap(~year)

gapminder %>% filter(year == 1952 & continent =="Asia") %>% ggplot(aes(reorder(country, pop), pop)) + geom_bar(stat = "identity") + coord_flip()

gapminder %>% filter(year==1952 & continent== "Asia") %>% ggplot(aes(reorder(country, pop), pop)) + geom_bar(stat  = "identity") + scale_y_log10() + coord_flip()

gapminder %>% filter(country == "Korea, Rep.") %>% ggplot(aes(year, lifeExp, col = country)) + geom_point() + geom_line()

gapminder %>% ggplot(aes(x = year, y = lifeExp, col = continent)) + geom_point(alpha = 0.2) + geom_smooth()

x = filter(gapminder, year == 1952)
hist(x$lifeExp, main = "Histogram of lifeExp in 1952")

x %>% ggplot(aes(lifeExp)) + geom_histogram()

x %>% ggplot(aes(continent, lifeExp)) + geom_boxplot()

plot(log10(gapminder$gdpPercap), gapminder$lifeExp)



# 03 �ð�ȭ ���� #

head(cars)

# type = "p"�� �� �÷�, main = "cars"�� �׷����� ����
plot(cars, type  = "p", main  = "cars")

plot(cars, type = "l", main = "cars")       # type ="l"�� ���� ����� �÷�
plot(cars, type="b", main="cars")   # type ="b"�� ���� ���� ��� ����� �÷�
plot(cars, type = "h", main = "cars")  # type ="h"�� ������׷��� ���� ���� �׷���

x = gapminder %>% filter(year == 1952 & continent == "Asia") %>% mutate(gdp = gdpPercap*pop) %>% select(country, gdp) %>% arrange(desc(gdp)) %>% head()
pie(x$gdp, x$country)
barplot(x$gdp, names.arg = x$country)


x = gapminder %>% filter(year == 2007 & continent == "Asia") %>% mutate(gdp  = gdpPercap*pop) %>% select(country, gdp) %>% arrange(desc(gdp)) %>% head()
pie(x$gdp, x$country)
barplot(x$gdp, names.arg = x$country)


matplot(iris[, 1:4], type = "l")
legend("topleft", names(iris)[1:4], lty = c(1, 2, 3, 4), col = c(1, 2, 3, 4))



hist(cars$speed)


ggplot(gapminder, aes(x = gdpPercap, y = lifeExp, col = continent)) + geom_point(alpha = 0.2)

gapminder %>% filter(lifeExp>70) %>% group_by(continent) %>% summarize(n = n_distinct(country)) %>% ggplot(aes(x = continent, y = n)) + geom_bar(stat = "identity")


gapminder %>% filter(year == 2007) %>%  ggplot(aes(lifeExp, col = continent)) + geom_histogram()
gapminder %>% filter(year == 2007) %>% ggplot(aes(lifeExp, col = continent)) + geom_histogram(position = "dodge")

gapminder %>% filter(year == 2007) %>% ggplot(aes(continent, lifeExp, col = continent)) + geom_boxplot()

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp, col = continent)) + geom_point(alpha = 0.2)
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp, col = continent)) + geom_point(alpha = 0.2) + scale_x_log10() # �������� �α� �����Ϸ� ��ȯ��.


gapminder %>% filter(continent == "Africa") %>% ggplot(aes(country, lifeExp)) + geom_bar(stat  =  "identity")                  # [�׸� 6-35(a)]

gapminder %>% filter(continent == "Africa") %>% ggplot(aes(country, lifeExp)) + geom_bar(stat  =  "identity") + coord_flip()    # [�׸� 6-35(b)] �÷��� ������ ��ȯ��. 


install.packages("RColorBrewer")
library(RColorBrewer)

display.brewer.all()


# [�׸� 6-37(a)] : �⺻ �ȷ�Ʈ�� ������ �׷���
gapminder %>% filter(lifeExp>70) %>% group_by(continent) %>% summarize(n  = n_distinct(country)) %>% ggplot(aes(x = continent, y = n)) + geom_bar(stat = "identity", aes(fill = continent)) 

# [�׸� 6-37(b)] : Spectral �ȷ�Ʈ�� ������ �׷���
gapminder %>% filter(lifeExp>70) %>% group_by(year, continent) %>% summarize(n = n_distinct(country)) %>% ggplot(aes(x = continent, y = n)) + geom_bar(stat = "identity", aes(fill = continent)) + scale_fill_brewer(palette = "Spectral")

# [�׸� 6-37(c)] Blues �ȷ�Ʈ�� ������ �׷���
gapminder %>% filter(lifeExp>70) %>% group_by(continent) %>% summarize(n = n_distinct(country)) %>% ggplot(aes(x = continent, y = n)) + geom_bar(stat = "identity", aes(fill = continent)) + scale_fill_brewer(palette = "Blues")

# [�׸� 6-37(d)] Oranges �ȷ�Ʈ�� ������ �׷���
gapminder %>% filter(lifeExp>70) %>% group_by(continent) %>% summarize(n =  n_distinct(country)) %>% ggplot(aes(x = continent, y = n)) + geom_bar(stat = "identity", aes(fill =  continent)) + scale_fill_brewer(palette = "Oranges")


# reorder(continent, -n)�� continent�� n�� �������� ������ ������ �����϶�� �ǹ�
gapminder %>% filter(lifeExp >70) %>% group_by(continent) %>% summarize(n  =  n_distinct(country)) %>% ggplot(aes(x = reorder(continent, -n), y =  n)) + geom_bar(stat = "identity", aes(fill =  continent)) + scale_fill_brewer(palette  = "Blues")


# 04 �ð�ȭ�� �̿��� ������ Ž�� #

gapminder %>% ggplot(aes(gdpPercap, lifeExp, col = continent)) + geom_point(alpha  =  0.2) + facet_wrap(~year) + scale_x_log10()

gapminder %>% filter(year == 1952 & gdpPercap > 10000 & continent == "Asia") 

gapminder %>% filter(country == "Kuwait") %>% ggplot(aes(year, gdpPercap)) + geom_point() + geom_line()             # [�׸� 6-40(a)]
gapminder %>% filter(country == "Kuwait") %>% ggplot(aes(year, pop)) + geom_point() + geom_line()                   # [�׸� 6-40(b)]

gapminder %>% filter(country == "Korea, Rep.") %>% ggplot(aes(year, gdpPercap)) + geom_point() + geom_line()        # [�׸� 6-41(a)]
gapminder %>% filter(country == "Korea, Rep.") %>% ggplot(aes(year, pop)) + geom_point() + geom_line()              # [�׸� 6-41(b)]

gapminder %>% filter(country == "Kuwait" | country == "Korea, Rep.") %>% mutate(gdp = gdpPercap*pop) %>% ggplot(aes(year, gdp, col = country)) + geom_point() + geom_line()

# [�׸� 6-43(a)] gdpPercap�� ��ȭ �� 
gapminder %>% filter(country == "Kuwait"|country == "Saudi Arabia"|country == "Iraq"|country == "Iran"|country == "Korea, Rep."|country == "China"|country == "Japan")  %>% ggplot(aes(year, gdpPercap, col = country)) + geom_point() + geom_line()

# [�׸� 6-43(b)] pop�� ��ȭ �� 
gapminder %>% filter(country == "Kuwait"|country=="Saudi Arabia"|country == "Iraq"|country == "Iran"|country == "Korea, Rep."|country == "China"|country == "Japan")  %>% ggplot(aes(year, pop, col=country)) + geom_point() + geom_line()

# [�׸� 6-43(c)] gdp�� ��ȭ �� 
gapminder %>% filter(country == "Kuwait"|country == "Saudi Arabia"|country == "Iraq"|country == "Iran"|country == "Korea, Rep."|country == "China"|country == "Japan")  %>% mutate(gdp=gdpPercap*pop) %>% ggplot(aes(year, gdp, col = country)) + geom_point() + geom_line() + scale_y_log10()
