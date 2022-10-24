getwd()

setwd('C:/Sources')
getwd()

install.packages("dplyr")
install.packages("ggplot2")

library(dplyr)
library(ggplot2)


str(iris)
head(iris, 10)
plot(iris)

plot(iris$Petal.Width, iris$Petal.Length, col = iris$Species)

tips = read.csv('https://raw.githubusercontent.com/mwaskom/seaborn-data/master/tips.csv')
str(tips)
head(tips, 10)


summary(tips)                # ��� ��踦 ������


library(dplyr)
library(ggplot2)

# �׸� 2-19(a)~(d)
tips%>%ggplot(aes(size)) + geom_histogram()                                           # �׸� 2-19(a)
tips%>%ggplot(aes(total_bill, tip)) + geom_point()                                    # �׸� 2-19(b)
tips%>%ggplot(aes(total_bill, tip)) + geom_point(aes(col = day))                      # �׸� 2-19(c)
tips%>%ggplot(aes(total_bill, tip)) + geom_point(aes(col = day, pch = sex), size = 3) # �׸� 2-19(d)

