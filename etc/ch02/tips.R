tips=read.csv("https://raw.githubusercontent.com/mwaskom/seaborn-data/master/tips.csv", stringsAsFactors = T)
str(tips)
head(tips, 10)

summary(tips)

library(dplyr)
library(ggplot2)
tips %>% ggplot(aes(total_bill, tip)) +
  geom_point()

# 색을 사용하여 요일 정보를 추가
tips %>% ggplot(aes(total_bill, tip)) +
  geom_point(aes(col=day))

# 기호로 남자와 여자를 구분
tips %>% ggplot(aes(total_bill, tip)) +
  geom_point(aes(col=day, pch=sex), size=3)
