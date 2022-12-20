# 0. 데이터 읽기 및 간단한 전처리 수행
setwd("~/workspace/R")
wisconsin = read.csv("wisconsin.csv")
str(wisconsin)
View(wisconsin)
summary(wisconsin)

# wjscjfl
table(is.na(wisconsin))
clean_wisconsin = na.omit(wisconsin) # 결측치 처리
table(is.na(clean_wisconsin))
clean_wisconsin$Diagnosis = as.factor(clean_wisconsin$Diagnosis) # 반응변수 Diagnosis 범주화
str(clean_wisconsin$Diagnosis)

# 1. 데이터 상관관계 분석

# Diagnosis와 설명변수(Radius_mean, Radius_se, Radius_extreme, Area_mean, Area_se, Area_extreme)와의 상관관계를 그래프를 그려서 분석
library(dplyr)
library(ggplot2)

clean_wisconsin %>%
  ggplot(aes(Radius_mean, Diagnosis)) + 
  geom_jitter(aes(col=Diagnosis), height=0.3, width=0.0) + 
  geom_boxplot(alpha=0.3)

# Radius_se
clean_wisconsin %>%
  ggplot(aes(Radius_se, Diagnosis)) + 
  geom_jitter(aes(col=Diagnosis), height=0.3, width=0.0) + 
  geom_boxplot(alpha = 0.3)

# Radius_extreme
clean_wisconsin %>%
  ggplot(aes(Radius_extreme, Diagnosis)) + 
  geom_jitter(aes(col=Diagnosis), height=0.3, width=0.0) + 
  geom_boxplot(alpha = 0.3)

# Area_mean
clean_wisconsin %>%
  ggplot(aes(Area_mean, Diagnosis)) + 
  geom_jitter(aes(col=Diagnosis), height=0.3, width=0.0) + 
  geom_boxplot(alpha = 0.3)

# Area_se
clean_wisconsin %>%
  ggplot(aes(Area_se, Diagnosis)) + 
  geom_jitter(aes(col=Diagnosis), height=0.3, width=0.0) + 
  geom_boxplot(alpha = 0.3)

# Area_extreme
clean_wisconsin %>%
  ggplot(aes(Area_extreme, Diagnosis)) + 
  geom_jitter(aes(col=Diagnosis), height=0.3, width=0.0) + 
  geom_boxplot(alpha = 0.3)

# 2. 결정트리 및 랜덤포리스트 모델 훈련(rpart, randomForest 함수 이용) 및 분석
select_wisconsin = clean_wisconsin %>%
  select(-1)

# 결정트리 모델 훈련 및 분석
library(rpart)
r = rpart(Diagnosis~., data=select_wisconsin)
print(r)

# 모델 분석
library(rpart.plot)
rpart.plot(r, extra=1)
printcp(r)

summary(r)
r_pred = predict(r, select_wisconsin, type='class') # 훈련집합으로 예측 및 혼동 행렬 작성
table(r_pred, select_wisconsin$Diagnosis)

# 랜덤포리스트 모델 훈련 및 분석
library(randomForest)
f = randomForest(Diagnosis~., data=select_wisconsin)
print(f)

# 모델 분석
plot(f)
varUsed(f)
varImpPlot(f)
treesize(f)

f_pred = predict(f, select_wisconsin) # 훈련집합으로 예측 및 혼동 행렬 작성
table(f_pred, select_wisconsin$Diagnosis)

# 3. 여러 모델의 성능비교(caret 패키지 이용)
library(caret)
control = trainControl(method='cv', number=5)
r = train(Diagnosis~., data = select_wisconsin, method = 'rpart', metric = 'Accuracy', trControl = control)
f = train(Diagnosis~., data = select_wisconsin, method = 'rf', metric = 'Accuracy', trControl = control)
k = train(Diagnosis~., data = select_wisconsin, method = 'knn', metric = 'Accuracy', trControl = control)
s = train(Diagnosis~., data = select_wisconsin, method = 'svmRadial', metric = 'Accuracy', trControl = control)
g = train(Diagnosis~., data = select_wisconsin, method = 'glm', family = binomial, metric = 'Accuracy', trControl = control)

resamp = resamples(list(결정트리 = r, 랜덤포리스트 = f, SVM = s, kNN = k, GLM = g))
summary(resamp)
sort(resamp, decreasing = T)
dotplot(resamp)
