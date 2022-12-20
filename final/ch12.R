library(stringr)
setwd("~/workspace/R")
x = read.csv('googleplaystore.csv', fileEncoding = 'utf-8')
str(x)
View(x)
x = x[-10473, ]

# Size열에서 값 대신 "Varies with device"로 표기된 데이터를 NA로 표시함
x$Size = sub("Varies with device", NA, x$Size)
x$Size = sub("M", "e6", x$Size, fixed = TRUE)
x$Size = sub("k", "e3", x$Size, fixed = TRUE)
x$Size = as.numeric(x$Size)

# Installs 열에 기록된 숫자보다 더 크다는 의미의 + 기호가 포함된 관측값과 
# 1,000 단위 숫자 구분에 사용되는 ,가 포함된 관측값이 있으므로
# str_replace, str_replace_all 함수를 사용해 빈 문자로 치환하여 처리함
x$Installs = str_replace(x$Installs, '\\+', '')
x$Installs = str_replace_all(x$Installs, ',', '')
x$Installs = as.numeric(x$Installs)

# Price에 포함된 $ 기호를 제거하고, 숫자형으로 변환
x$Price = str_replace(x$Price, "\\$", '')
x$Price = as.numeric(x$Price)

# 데이터 원본에 있던 결측값과 문자열, 기호 등의 처리 과정에서 생긴 결측값을 제거함
x = na.omit(x)

# 각 측정 항목의 데이터형을 고려하여 나머지 변수의 형 변환을 실행함
x$Category = factor(x$Category)
x$Reviews = as.numeric(x$Reviews)
x$Type = factor(x$Type)
x$Content.Rating = factor(x$Content.Rating)
x$Genres = factor(x$Genres)

# 마지막 Date형의 손쉬운 변환을 위해 lubridate 라이브러리의 mdy 함수를 이용할 수 있음
library(lubridate)
x$Last.Updated = mdy(x$Last.Updated)

library(dplyr)
glimpse(x)

# 평점분포
library(ggplot2)
x %>% ggplot(aes(Rating)) + geom_histogram()

# histogram - sample 수가 차이나 비교가 힘듦
x %>% ggplot(aes(Rating, fill=Type)) + geom_histogram(position='dodge')

# density - sample 수가 아닌 비율로 비교
x %>% ggplot(aes(Rating, col = Type)) + geom_density()

# 평점과 리뷰의 관계
x %>% ggplot(aes(Reviews, Rating, col = Type)) + geom_point(alpha = 0.2) + scale_x_log10()

# 평점과 리뷰, 설치 횟수의 관계
x %>% ggplot(aes(Reviews, Rating, col = Type, size = Installs)) + geom_point(alpha = 0.2) + scale_x_log10()
x %>% ggplot(aes(Reviews, Rating, size = Installs)) + geom_point(alpha = 0.2) + scale_x_log10() + facet_wrap(~Type)

x %>% filter(Type == "Paid") %>% ggplot(aes(Reviews, Rating, size = Installs)) + geom_point(alpha = 0.2) + scale_x_log10()

# 리뷰~설치 횟수
x %>% ggplot(aes(Reviews, Installs)) + geom_point(alpha = 0.2) + scale_x_log10() + scale_y_log10()
x %>% ggplot(aes(Reviews, Installs)) + geom_point(alpha = 0.2) + scale_x_log10() + scale_y_log10() + geom_jitter()

# 평점~가격
x %>% filter(Type=="Paid" & Price < 5) %>% ggplot(aes(Price)) + geom_histogram(binwidth = 0.01)
x %>% filter(Type=="Paid" & Price > 5 & Price < 10) %>% ggplot(aes(Price)) + geom_histogram(binwidth = 0.01)

x %>% filter(Type == "Paid") %>% ggplot(aes(Price, Rating)) + geom_point(alpha = 0.2)
x %>% filter(Type == "Paid") %>% ggplot(aes(Price, Rating)) + geom_point(alpha = 0.2) + scale_x_log10()
x %>% filter(Type == "Paid" & Price < 50) %>% ggplot(aes(Price, Rating)) + geom_point(alpha = 0.2)

top4 <- x %>% group_by(Category) %>% summarize(n = n()) %>% arrange(desc(n)) %>% head(4)
top4

x %>% filter(Type == "Paid" & Price < 50  & Category %in% top4$Category) %>%
  ggplot(aes(Price, Rating)) + geom_point(alpha = 0.2) + facet_wrap(~Category)

# 평점 ~ 크기
x %>% ggplot(aes(Size, Rating)) + geom_point(alpha = 0.1)
         
# 평점 ~ 콘텐츠 등급
x %>% ggplot(aes(Content.Rating, Rating)) + geom_point(alpha = 0.1) + geom_jitter( )
x %>% ggplot(aes(Rating, col=Content.Rating)) + geom_density()
x %>% filter(Content.Rating!="Adults only 18+") %>% ggplot(aes(Rating, col=Content.Rating)) + geom_density()

# 평점 ~ 카테고리
x %>% ggplot(aes(Category, Rating)) + geom_point(size = 0.1, position= "jitter") + coord_flip()

# 다중 선형 회귀 모델
m = lm(Rating~Size+Content.Rating+Category, data = x)
m
deviance(m)/nrow(x)

library(caret)
ps = select(x, Rating, Category, Size, Content.Rating)
control = trainControl(method='cv', number = 10)
m = train(Rating~., data=ps, method='lm', metric='RMSE', trControl = control)
m
m$resample
m$results

ps = select(x, Rating, Category, Size)
control = trainControl(method = 'cv', number = 10)
m = train(Rating~., data=ps, method='lm', metric='RMSE', trControl = control)
g = train(Rating~., data=ps, method='glm', metric='RMSE', trControl = control)
r = train(Rating~., data=ps, method='rpart', metric='RMSE', trControl = control)
f = train(Rating~., data=ps, method='rf', metric='RMSE', trControl = control)
s = train(Rating~., data=ps, method='svmRadial', metric='RMSE', trControl = control)
resmp = resamples(list(선형=m, 일반화선형=g, 결정트리=r, 랜덤포리스트=f, SVM=s))
summary(resmp)
dotplot(resmp)
