# 02 데이터 정제 #
install.packages("stringr")
library(stringr)

# 문자형 데이터를 문자형 그대로 읽어들임(factor형 변환 비활성화)
x = read.csv("C:/Sources/googleplaystore.csv", header = TRUE, sep = ",", as.is = TRUE)

# Price에 포함된 $ 기호를 제거함
x$Price = str_replace(x$Price, '\\$', '')

# 10473행의 데이터 항목 중 일부가 누락되어 제거함
x = x[-10473, ]

# Size열에서 값 대신 “Varies with device”로 표기된 데이터를 NA로 표시함
# Mega byte를 의미하는 문자 M은 10의 6제곱으로 치환
# Kilo byte를 의미하는 문자 k도 10의 3제곱으로 치환
# Sys.setlocale('LC_ALL','C') 
x$Size = sub("Varies with device", NA, x$Size)     
x$Size = sub("M", "e6", x$Size, fixed = TRUE)
x$Size = sub("k", "e3", x$Size, fixed = TRUE)

# 문자열과 기호를 처리한 후 최종적으로 숫자형 데이터로 변환함 
x$Size = as.numeric(x$Size)

# Installs 열에 기록된 숫자보다 더 크다는 의미의 + 기호가 포함된 관측값과 
# 1,000 단위 숫자 구분에 사용되는 ,가 포함된 관측값이 있으므로 
# str_replace 함수를 사용해 빈 문자로 치환하여 처리함 
x$Installs = str_replace(x$Installs, '\\+', '')
x$Installs = str_replace_all(x$Installs, ', ', '' )

# 숫자형으로 변환함. 
x$Installs = as.numeric(x$Installs)

# 데이터 원본과 문자열, 기호 등의 처리 과정에서 생긴 결측값을 제거함 
x = na.omit(x)

# 데이터 결함을 제거한 후 각 측정 항목의 데이터형을 고려하여 형 변환을 시행함
x$Category = as.factor(x$Category)
x$Reviews = as.numeric(x$Reviews)
x$Type = as.factor(x$Type)
x$Price = as.numeric(x$Price)
x$Content.Rating = as.factor(x$Content.Rating)
x$Genres = as.factor(x$Genres)

# 마지막 Date형의 손쉬운 변환을 위해 lubridate 라이브러리의 mdy 함수를 이용할 수 있음 
library(lubridate)
x$Last.Updated = mdy(x$Last.Updated) 


library(dplyr)
glimpse(x)

View(x)


# 03 탐색적 데이터 분석 #
x%>%ggplot(aes(Rating)) + geom_histogram()

x%>%ggplot(aes(Rating, fill = Type)) + geom_histogram(position = "dodge")

x%>%ggplot(aes(Rating, col = Type)) + geom_density()

x%>%ggplot(aes(Reviews, Rating, col = Type)) + geom_point(alpha = 0.2) + scale_x_log10()

x%>%ggplot(aes(Reviews, Rating, col = Type, size = Installs)) + geom_point(alpha = 0.2) + scale_x_log10()

x%>%ggplot(aes(Reviews, Rating, size = Installs)) + geom_point(alpha = 0.2) +scale_x_log10() + facet_wrap(~Type)

x%>%filter(Type=="Paid")%>%ggplot(aes(Reviews, Rating, size = Installs)) + geom_point(alpha = 0.2) + scale_x_log10() 

x%>%ggplot(aes(Reviews, Installs)) + geom_point(alpha = 0.2) + scale_x_log10() + scale_y_log10()

x%>%ggplot(aes(Reviews, Installs)) + geom_point(alpha = 0.2) + scale_x_log10() + scale_y_log10() + geom_jitter()

x%>%filter(Type =="Paid" & Price < 5)%>%ggplot(aes(Price)) + geom_histogram(binwidth = 0.01)

x%>%filter(Type =="Paid" & Price < 10 & Price > 5)%>%ggplot(aes(Price)) + geom_histogram(binwidth = 0.01)

x%>%filter(Type =="Paid")%>%ggplot(aes(Price, Rating)) + geom_point(alpha = 0.2)

x%>%filter(Type=="Paid")%>%ggplot(aes(Price, Rating)) + geom_point(alpha = 0.2) + scale_x_log10()

top4 <- x%>%group_by(Category)%>%summarize(n = n())%>%arrange(desc(n))%>%head(4)

top4

x%>%filter(Type=="Paid" & Price < 50 & Category %in% top4$Category)%>%ggplot(aes(Price, Rating)) + geom_point(alpha = 0.2) + facet_wrap(~Category)

x%>%ggplot(aes(Size, Rating)) + geom_point(alpha = 0.1)

x%>%ggplot(aes(Content.Rating, Rating)) + geom_point(alpha = 0.1) + geom_jitter()
x%>%filter(Content.Rating!= "Adults only 18 +")%>%ggplot(aes(Rating, col = Content.Rating)) + geom_density()

x%>%ggplot(aes(Category, Rating)) + geom_point(size = 0.1, position = "jitter") + coord_flip()


# 04 모델링과 예측 #

# 다중 선형 회귀 분석
m = lm(Rating ~ Size + Content.Rating + Category, data = x)

# 선형 모델의 계수 확인
m

# mse 산출
deviance(m)/nrow(x)

# 10-fold cross-validation for linear regression
ps = select(x, Rating, Category, Size, Content.Rating)
library(caret)
data = ps[sample(nrow(ps)), ]
k = 10
q = nrow(data)/k
l = 1:nrow(data)

te_total = c()
pe_total = c()
for(i in 1:k) {
  test_list = ((i-1) * q+1) : (i * q)
  testData = data[test_list,]
  train_list = setdiff(l, test_list)
  trainData = data[train_list, ]
  
  m = lm(Rating~., data = trainData)
  # print(residuals(m))
  te = deviance(m)/nrow(trainData)        # mean squared error
  te_total = c(te_total, te)
  
  prd = predict(m, newdata = testData)
  pe = mean((prd-testData$Rating)^2)       # mean squared error
  pe_total = c(mse_total, pe)
}

(te_total)
(pe_total)

# 설명 변수의 모든 조합(주석 표시된 모든 조합 중에서 하나씩 차례로 주석을 해제하여 실행한다.)
ps = select(x, Rating, Category)
#ps = select(x, Rating, Size)
#ps = select(x, Rating, Content.Rating)
#ps = select(x, Rating, Category, Size)
#ps = select(x, Rating, Category, Content.Rating)
#ps = select(x, Rating, Size, Content.Rating)
#ps = select(x, Rating, Category, Size, Content.Rating)



# 결정 트리 모델
library(rpart)			# rpart 라이브러리 

r = rpart(Rating~., data = trainData)			# 모델 학습
prd = predict(r, newdata = testData)			# 모델에 의한 예측

# 랜덤 포리스트 모델(랜덤 포리스트 라이브러리)
library(randomForest)	# 랜덤 포리스트 라이브러리

f = randomForest(Rating~., data = trainData)	# 모델 학습
prd = predict(f, newdata = testData)	# 모델에 의한 예측


# 랜덤 포리스트 모델(SVM 라이브러리)
library(e1071)		# SVM 라이브러리

f = svm(Rating~., data = trainData)		# 모델 학습
prd = predict(f, newdata = testData)		# 모델에 의한 예측


# [더 알아보기] FAMILY 앱이 대세? #
x%>%group_by(Category, Genres)%>%summarise(n = n())%>%arrange(Category)%>%ggplot(aes(Category, Genres, size = n)) + geom_point() + theme(axis.text.y = element_text(size = 5), axis.text.x = element_text(size = 7, angle = -45, hjust = 0, vjust = 0))
