library(caret)
library(randomForest)

# 일반화 능력 측정
train_list = createDataPartition(y = iris$Species, p = 0.6, list = FALSE)
train_list

iris_train=iris[train_list,]
iris_test=iris[-train_list,]
f=randomForest(Species~., data=iris_train)
p=predict(f, newdata=iris_test)
table(p, iris_test$Species)

# 교차 검증
control = trainControl(method='cv', number=5)
f = train(Species~., data=iris, method='rf', metric='Accuracy', trControl=control)
confusionMatrix(f)

# 모델 선택
control = trainControl(method='cv', number = 5)
r = train(Species~., data=iris, method='rpart', metric='Accuracy', trControl=control)
f = train(Species~., data=iris, method='rf', metric='Accuracy', trControl=control)
s = train(Species~., data=iris, method='svmRadial', metric='Accuracy', trControl=control)
k = train(Species~., data=iris, method='knn', metric='Accuracy', trControl=control)
resamp = resamples(list(결정트리 = r, 랜덤포레스트 = f, SVM = s, kNN = k))

summary(resamp)

library(survival)
clean_colon=na.omit(colon)
clean_colon = clean_colon[c(TRUE, FALSE),] # 홀수 행만 살리기
clean_colon$status=factor(clean_colon$status) # 분류 예측이므로 반응 변수를 factor 형으로 변경
control = trainControl(method='cv', number=10) 

fomular=status~rx+sex+age+obstruct+perfor+adhere+nodes+differ+extent+surg+node4
L = train(fomular, data=clean_colon, method='svmLinear', metric='Accuracy', trControl=control)
LW = train(fomular, data=clean_colon, method='svmLinearWeights', metric='Accuracy', trControl=control)
P = train(fomular, data=clean_colon, method='svmPoly', metric='Accuracy', trControl=control)
R = train(fomular, data=clean_colon, method='svmRadial', metric='Accuracy', trControl=control)
RW = train(fomular, data=clean_colon, method='svmRadialWeights', metric='Accuracy', trControl=control)

f100 = train(fomular, data=clean_colon, method='rf', ntree = 100, metric='Accuracy', trControl=control)
f300 = train(fomular, data=clean_colon, method='rf', ntree = 300, metric='Accuracy', trControl=control)
f500 = train(fomular, data=clean_colon, method='rf', ntree = 500, metric='Accuracy', trControl=control)

r = train(fomular, data=clean_colon, method='rpart', metric='Accuracy', trControl=control)
k = train(fomular, data=clean_colon, method='knn', metric='Accuracy', trControl=control)
g = train(fomular, data=clean_colon, method='glm', metric='Accuracy', trControl=control)

resamp = resamples(list(선형=L, 선형가중치=LW, 다항식=P, RBP=R, 가중치=RW, rf100=f100, rf300=f300, rf500=f500, tree=r, knn=k, glm=g))
summary(resamp)
names(getModelInfo())
