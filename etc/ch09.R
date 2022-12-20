install.package("rpart")
library(rpart)
r = rpart(Species~., data=iris)
print(r)

library(rpart.plot)
rpart.plot(r, extra=1, digits=3)


predict(r, iris, type='class')
predict(r, iris, type='prob')
p = predict(r, iris, type='class')
table(p)
table(p, iris$Species)
table(iris$Species, p)


library(randomForest)
f = randomForest(Species~., data=iris)

f
plot(f)

varUsed(f)
varImpPlot(f)
treesize(f)

newd = data.frame(Sepal.Length = c(5.11, 7.01, 6.32), Sepal.Width=c(3.51, 3.2, 3.31), Petal.Length = c(1.4, 4.71, 6.02), Petal.Width = c(0.19, 1.4, 2.49))
predict(f, newdata=newd)

predict(f, newdata=newd, type = 'prob')

predict(f, newdata = newd, type='vote', norm.votes=FALSE)

small_forest=randomForest(Species~., data=iris, ntree=20, nodesize=6, maxnodes=12)
treesize(small_forest)
small_forest            

library(e1071)
s = svm(Species~., data=iris)
print(s)
table(predict(s, iris), iris$Species)

library(class)
train=iris
test=data.frame(Sepal.Length = c(5.11, 7.01, 6.32), Sepal.Width=c(3.51, 3.2, 3.31), Petal.Length = c(1.4, 4.71, 6.02), Petal.Width = c(0.19, 1.4, 2.49))
k = knn(train[,1:4], test, train$Species, k=5)
k

nn = nnet(Species~., iris, size=2)
library(devtools)
plot.nnet(nn)
p = predict(nn, iris, type='class')
