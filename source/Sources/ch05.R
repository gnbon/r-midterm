# 02 베이스 R을 이용한 데이터 가공 # 

library(gapminder) 
library(dplyr)
glimpse(gapminder)


gapminder[, c("country", "lifeExp")]

gapminder[, c("country", "lifeExp", "year")]

gapminder[1:15, ]

gapminder[gapminder$country == "Croatia", ]


gapminder[gapminder$country == "Croatia", "pop"]


gapminder[gapminder$country == "Croatia", c("lifeExp","pop")]

gapminder[gapminder$country == "Croatia" & gapminder$year > 1990, c("lifeExp","pop")]


apply(gapminder[gapminder$country == "Croatia", c("lifeExp","pop")], 2, mean)



# 03 dplyr 라이브러리를 이용한 데이터 가공 # 
select(gapminder, country, year, lifeExp)

filter(gapminder, country == "Croatia")

summarise(gapminder, pop_avg = mean(pop))

summarise(group_by(gapminder, continent), pop_avg = mean(pop))

summarise(group_by(gapminder, continent, country), pop_avg = mean(pop))

gapminder %>% group_by(continent, country) %>% summarise(pop_avg = mean(pop))


temp1 = filter(gapminder, country == "Croatia")      
temp2 = select(temp1, country, year, lifeExp)  
temp3 = apply(temp2[ , c("lifeExp")], 2, mean)
temp3

gapminder %>% filter(country == "Croatia") %>% select(country, year, lifeExp) %>% summarise(lifeExp_avg = mean(lifeExp))


# 04 데이터 가공의 실제 # 
avocado <- read.csv("C:/Sources/avocado.csv", header=TRUE, sep = ",")

str(avocado)

(x_avg = avocado %>% group_by(region) %>% summarize(V_avg = mean(Total.Volume), P_avg = mean(AveragePrice)))

(x_avg = avocado %>% group_by(region, year) %>% summarize(V_avg = mean(Total.Volume), P_avg = mean(AveragePrice)))

x_avg = x %>% group_by(region, year, type) %>% summarize(V_avg = mean(Total.Volume), P_avg = mean(AveragePrice))

x_avg %>% filter(region != "TotalUS") %>% ggplot(aes(year, V_avg, col = type)) + geom_line() + facet_wrap(~region)

install.packages("ggplot2")
library(ggplot2)

arrange(x_avg, desc(V_avg))

x_avg1 = x_avg %>% filter(region != "TotalUS")

# TotalUS를 제외하고 나면 통계 함수를 직접 사용하여 처리할 수 있음. 
x_avg1[x_avg$V_avg == max(x_avg1$V_avg), ]

install.packages("lubridate")
library(lubridate)

(x_avg = avocado %>% group_by(region, year, month(Date), type) %>% summarize(V_avg = mean(Total.Volume), P_avg = mean(AveragePrice)))

wine <- read.table("C:/Sources/wine.data.txt", header = TRUE, sep = ",")

head(wine)

n = readLines("C:/Sources/wine.name.txt")
n

names(wine)[2:14] <- substr(n, 4, nchar(n))
names(wine)


train_set = sample_frac(wine, 0.6)
str(train_set)

test_set = setdiff(wine, train_set)
str(test_set)

elec_gen = read.csv("C:/Sources/electricity_generation_per_person.csv", header = TRUE, sep = ",")

names(elec_gen)

names(elec_gen) = substr(names(elec_gen), 2, nchar(names(elec_gen)))

names(elec_gen)

elec_use = read.csv("C:/Sources/electricity_use_per_person.csv", header = TRUE, sep = ",")
names(elec_use)[2:56] = substr(names(elec_use)[2:56], 2, nchar(names(elec_use)[2:56]))

install.packages("tidyr")
library(tidyr)
elec_gen_df = gather(elec_gen, -country, key = "year", value = "ElectricityGeneration")
elec_use_df = gather(elec_use, -country, key = "year", value = "ElectricityUse")

elec_gen_use = merge(elec_gen_df, elec_use_df)