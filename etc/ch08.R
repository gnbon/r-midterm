muffler = data.frame(discount = c(2, 4, 6, 8, 10), profit = c(0, 0, 0, 1, 1))
plot(muffler, pch=20, cex=2, xlim=c(0, 12))

m = lm(profit~discount, data=muffler)

coef(m)
fitted(m)
residuals(m)
deviance(m)

plot(muffler, pch=20, cex=2, xlim=c(0, 12))
abline(m)

# 새로운 할인율에 대해 예측
newd = data.frame(discount = c(1, 5, 12, 20, 30))
p = predict(m, newd)
print(p)

# 일반화 선형 모델 적용
g = glm(profit~discount, data=muffler, family=binomial)
coef(g)
fitted(g)
residuals(g)
deviance(g)

plot(muffler, pch=20, cex=2, xlim=c(0, 12))
abline(g, col='blue', lwd=2)

plot(muffler, pch=20, cex=2, xlim=c(0, 12))
newx = data.frame(discount=seq(2, 10, length.out=50))
y = predict(g, newx, type='response')
lines(newx$discount, y, col='red')

# Haberman survival data
haberman = read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/haberman/haberman.data", header = FALSE)
names(haberman) = c('age', 'op_year', 'no_nodes', 'survival')
str(haberman)

haberman$survival = factor(haberman$survival)
str(haberman)

h = glm(survival~age+op_year+no_nodes, data=haberman, family=binomial)
coef(h)
deviance(h)

new_patients=data.frame(age=c(37, 66), op_year=c(58, 60), no_nodes=c(5, 32))
predict(h, newdata=new_patients, type='response')

h = glm(survival~age+no_nodes, data=haberman, family=binomial)
coef(h)
deviance(h)

new_patients=data.frame(age=c(37, 66),  no_nodes=c(5, 32))
predict(h, newdata=new_patients, type='response')

# UCLA data
ucla = read.csv('https://stats.idre.ucla.edu/stat/data/binary.csv')
str(ucla)

library(ggplot2)
library(dplyr)

plot(ucla)

ucla %>% ggplot(aes(gre, admit)) + geom_point()
ucla %>% ggplot(aes(gre, admit)) + geom_jitter()
ucla %>% ggplot(aes(gre, admit)) + geom_jitter(aes(col=admit))
ucla %>% ggplot(aes(gre, admit)) + geom_jitter(aes(col=factor(admit)))
ucla %>% ggplot(aes(gre, admit)) + geom_jitter(aes(col=factor(admit)), height = 0.1, width= 0.0)

install.packages("gridExtra")
library(gridExtra)

p1 = ucla %>% ggplot(aes(gpa, admit)) + geom_jitter(aes(col=factor(admit)), height = 0.1, width= 0.0)
p2 = ucla %>% ggplot(aes(rank, admit)) + geom_jitter(aes(col=factor(admit)), height = 0.1, width= 0.0)
grid.arrange(p1, p2, ncol=2)

m = glm(admit~., data=ucla, family=binomial)
coef(m)
deviance(m, type='responce')

s = data.frame(gre=c(376), gpa=c(3.6), rank=c(3))
predict(m, new_data=s, type='response')

# colon data
library(survival)
str(colon)

m = glm(status~., data = colon, family = binomial)
m

table(is.na(colon))
clean_colon = na.omit(colon)
m = glm(status~., data = clean_colon, family = binomial)
m

