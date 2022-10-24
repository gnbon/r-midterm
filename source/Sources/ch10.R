# 02 정확률 #

library(rpart)
library(randomForest)
library(caret)

r = rpart(Species~., data = iris)                     # 결정 트리 모델
f = randomForest(Species~., data = iris, ntree = 3)   # 랜덤 포리스트 모델
r_pred = predict(r, iris, type = 'class')

confusionMatrix(r_pred, iris$Species)
f_pred = predict(f, iris)
confusionMatrix(f_pred, iris$Species)


# 03 일반화 능력 측정 #
n = nrow(iris) # iris의 샘플 개수
i = 1:n			# 1, 2, 3, ..., n을 가진 리스트 i
train_list = sample(i, n*0.6)		# 60%를 랜덤하게 샘플링
test_list = setdiff(i, train_list)	# 나머지(40%) 
iris_train = iris[train_list, ]		# 훈련 집합 추출
iris_test = iris[test_list, ]		# 테스트 집합 추출

f = randomForest(Species~., data = iris_train) # 훈련 집합으로 랜덤 포리스트 학습
p = predict(f, newdata=iris_test)
p

iris_test$Species

library(caret)
train_list = createDataPartition(y = iris$Species, p = 0.6, list = FALSE)
iris_train = iris[train_list, ]
iris_test = iris[-train_list, ]
f = randomForest(Species~., data = iris_train)    # 훈련 집합으로 랜덤 포리스트 학습
p = predict(f, newdata = iris_test)


# 04 교차 검증 #
library(caret)
data = iris[sample(nrow(iris)), ] 	# iris 데이터의 순서를 섞는다.
k = 5
q = nrow(data)/k   			# k개로 등분했을 때 부분 집합의 크기
l = 1:nrow(data)
accuracy = 0
for(i in 1:k) {
       test_list = ((i-1)*q+1):(i*q)         # i번째를 테스트 집합으로 설정
       testData = data[test_list, ]
       train_list = setdiff(l, test_list) 	# 나머지를 훈련 집합으로 설정
       trainData = data[train_list, ]
       f = train(Species~., data = trainData, method = 'rf') # 모델 학습(랜덤 포리스트)
       p = predict(f, newdata = testData)
       t = table(p, testData$Species)
      accuracy=accuracy+(t[1, 1]+t[2, 2]+t[3, 3])/length(test_list) # 정확률 측정&누적
}
(average_accuracy = accuracy/k) 		# 평균 정확률


control = trainControl(method = 'cv', number = 5)
f = train(Species~., data = iris, method = 'rf', metric = 'Accuracy', trControl = control)
confusionMatrix(f)


# 05 모델 선택 #
control = trainControl(method = 'cv', number = 5)
r = train(Species~., data = iris, method = 'rpart', metric = 'Accuracy', trControl=control)
f = train(Species~., data = iris, method = 'rf', metric = 'Accuracy', trControl = control)
s = train(Species~., data = iris, method = 'svmRadial', metric = 'Accuracy', trControl = control)
k = train(Species~., data = iris, method = 'knn', metric = 'Accuracy', trControl = control)
resamp = resamples(list(결정트리 = r, 랜덤포리스트 = f, SVM = s, kNN = k))
summary(resamp)

sort(resamp, decreasing = TRUE)
dotplot(resamp)

library(survival)
clean_colon = na.omit(colon)
clean_colon = clean_colon[c(TRUE, FALSE), ]
clean_colon$status = factor(clean_colon$status)
control = trainControl(method = 'cv', number = 10)
formular = status~rx+sex+age+obstruct+perfor+adhere+nodes+differ+extent+surg+node4
L = train(formular, data = clean_colon, method = 'svmLinear', metric = 'Accuracy', trControl = control)
LW = train(formular, data = clean_colon, method = 'svmLinearWeights', metric = 'Accuracy', trControl = control)
P = train(formular, data = clean_colon, method = 'svmPoly', metric = 'Accuracy', trControl =  control)
R = train(formular, data = clean_colon, method = 'svmRadial', metric = 'Accuracy', trControl = control)
RW = train(formular, data = clean_colon, method = 'svmRadialWeights', metric = 'Accuracy', trControl = control)
f100 = train(formular, data = clean_colon, method = 'rf', ntree = 100, metric = 'Accuracy', trControl = control)
f300 = train(formular, data = clean_colon, method = 'rf', ntree = 300,metric = 'Accuracy', trControl = control)
f500 = train(formular, data = clean_colon, method = 'rf', ntree = 500,metric = 'Accuracy', trControl = control)
r = train(formular, data = clean_colon, method = 'rpart', metric = 'Accuracy', trControl = control)
k = train(formular, data = clean_colon, method = 'knn', metric = 'Accuracy', trControl = control)
g = train(formular, data = clean_colon, method = 'glm', metric = 'Accuracy', trControl = control)
resamp = resamples(list(선형 = L, 선형가중치 = LW, 다항식 = P, RBF = R, 가중치 = RW, rf100 = f100, rf300 = f300, rf500 = f500, tree = r, knn = k, glm = g))
summary(resamp)

sort(resamp, decreasing = TRUE)

dotplot(resamp)


# 07 ROC 곡선과 AUC #
install.packages('ROCR')
library(ROCR)
labels = c(0, 0, 1, 0, 1, 1, 0, 0, 0, 1)	
predictions = c(0.26, 0.81, 0.73, 0.11, 0.20, 0.48, 0.23, 0.11, 0.61, 0.99) 

p = prediction(predictions, labels)	
roc = performance(p, measure = 'tpr', x.measure = 'fpr')	
plot(roc)
abline(a = 0, b = 1)

auc = performance(p, measure = 'auc')	
auc@y.values



