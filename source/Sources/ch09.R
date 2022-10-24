# 03 결정 트리 함수의 사용터 #
iris

library(rpart)
r = rpart(Species~., data = iris)
printcp(r)  # 학습된 결정 트리에 대한 자세한 정보


par(mfrow = c(1, 1), xpd = NA)
plot(r)
text(r, use.n = TRUE)


p = predict(r, iris, type = 'class')
table(p, iris$Species)


r_prior = rpart(Species~., data = iris, parms = list(prior = c(0.1, 0.1, 0.8)))
plot(r_prior)
text(r_prior, use.n = TRUE)

# 예측
newd = data.frame(Sepal.Length = c(5.11, 7.01, 6.32), Sepal.Width = c(3.51, 3.2, 3.31), Petal.Length = c(1.4, 4.71, 6.02), Petal.Width = c(0.19, 1.4, 2.49))

# 출력
print(newd) 

predict(r, newdata = newd)



# 04 결정 트리의 해석 #
summary(r)


library(rpart.plot)
rpart.plot(r)
rpart.plot(r, type = 4)


# 05 랜덤 포리스트 #

# 랜덤 포리스트를 이용한 iris 데이터 분류
library(randomForest)
f = randomForest(Species~., data=iris)
# 학습된 결정 트리에 대한 자세한 정보
f 
# 학습된 결정 트리에 대한 더 자세한 정보
summary(f) 

plot(f)
varUsed(f)
varImpPlot(f)

treesize(f)

newd = data.frame(Sepal.Length = c(5.11, 7.01, 6.32), Sepal.Width = c(3.51, 3.2, 3.31), Petal.Length = c(1.4, 4.71, 6.02), Petal.Width = c(0.19, 1.4, 2.49))
predict(f, newdata = newd)

predict(f, newdata = newd, type = 'prob')

predict(f, newd, type = 'vote', norm.votes = FALSE)

small_forest=randomForest(Species~., data=iris, ntree=20, nodesize=6, maxnodes=12)



# 06 SVM과 k-NN #
library(e1071)
s = svm(Species~., data = iris)     # 기본 커널은 radial basis 사용
print(s)

table(predict(s, iris), iris$Species)  

table(p, iris$Species)

s = svm(Species~., data = iris,kernel = 'polynomial')  # polynomial 커널 사용
p = predict(s, iris)
table(p, iris$Species)

s = svm(Species~., data = iris, cost = 100)  # 기본 커널은 radial basis
p = predict(s, iris)
table(p, iris$Species)


library(class)
train = iris
test = data.frame(Sepal.Length = c(5.11, 7.01, 6.32), Sepal.Width = c(3.51, 3.2, 3.31), Petal.Length = c(1.4, 4.71, 6.02), Petal.Width = c(0.19, 1.4, 2.49))
k = knn(train[, 1:4], test, train$Species, k = 5)
k

library(caret)
r = train(Species~., data = iris, method = 'rpart')
f = train(Species~., data = iris, method = 'rf')
s = train(Species~., data = iris, method = 'svmRadial')
k = train(Species~., data = iris, method = 'knn')

# 07 분류 모델의 다양한 적용 #
ucla = read.csv('https://stats.idre.ucla.edu/stat/data/binary.csv')
str(ucla)
ucla$admit = factor(ucla$admit)

r = rpart(admit~., data = ucla)
par(mfrow = c(1, 1), xpd = NA)
plot(r)
text(r, use.n = TRUE)


p = predict(r, ucla, type = 'class')
table(p, ucla$admit)


f = randomForest(admit~., data = ucla)
print(f)


library(survival)
clean_colon = na.omit(colon)                 # 전처리: 결측값 제거
clean_colon = clean_colon[c(TRUE, FALSE), ]  # 전처리: 홀수 번째 것만 뽑음
clean_colon$status = factor(clean_colon$status)

str(clean_colon)

r = rpart(status~rx + sex + age + obstruct + perfor + adhere + nodes + differ + extent + surg + node4, data = clean_colon)
p = predict(r, clean_colon, type = 'class')
table(p, clean_colon$status)

plot(r)
text(r, use.n = TRUE)

summary(r)

f = randomForest(status~rx + sex + age + obstruct + perfor + adhere + nodes + differ + extent + surg + node4, data = clean_colon)
print(f)

treesize(f)


# voice 데이터
voice = read.csv('C:/Sources/voice.csv')
str(voice)

table(is.na(voice))
      
r = rpart(label~., data = voice)
par(mfrow = c(1, 1), xpd = NA)
plot(r)
text(r, use.n = TRUE)
      
p = predict(r, voice, type = 'class')
table(p, voice$label)
    
f = randomForest(label~., data = voice)
print(f)
      
      
treesize(f)
      
