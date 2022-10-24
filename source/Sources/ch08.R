# 01 일반화 선형 모델은 왜 필요한가? #

muffler = data.frame(discount = c(2.0, 4.0, 6.0, 8.0, 10.0), profit = c(0, 0, 0, 1, 1))
plot(muffler, pch = 20, cex = 2, xlim = c(0, 12))


m = lm(profit ~ discount, data = muffler)
coef(m)
fitted(m)
residuals(m)
deviance(m)


plot(muffler, pch = 20, cex = 2, xlim = c(0, 12))
abline(m)

newd = data.frame(discount = c(1, 5, 12, 20, 30))    # 5개의 새로운 할인율
p = predict(m, newd)
print(p)


plot(muffler, pch = 20, xlim = c(0, 32), ylim = c(-0.5, 4.2))
abline(m)
res = data.frame(discount = newd, profit = p)
points(res, pch = 20, cex = 2, col = 'red')
legend ("bottomright", legend = c("train data", "new data"), pch = c(20, 20), cex = 2, col = c("black", "red"), bg = "gray")


# 02 일반화 선형 모델 #
muffler = data.frame(discount = c(2.0, 4.0, 6.0, 8.0, 10.0), profit = c(0, 0, 0, 1, 1))
g = glm(profit~discount, data = muffler, family = binomial)

coef(g)
fitted(g)
residuals(g)
deviance(g)

# [그림 8-5] 
plot(muffler, pch = 20, cex = 2)
abline(g, col = 'blue', lwd = 2)


newd = data.frame(discount = c(1, 5, 12, 20, 30))   # 다섯 개의 새로운 할인율
p = predict(g, newd, type='response')
print(p)


# [그림 8-6] 
plot(muffler, pch = 20, cex = 2, xlim = c(0, 32))
abline(g, col = 'blue', lwd = 2)
res = data.frame(discount = newd, profit = p)
points(res, pch = 20, cex = 2, col = 'red')
legend ("bottomright", legend = c("train data", "new data"), pch = c(20, 20), cex = 2, col = c("black", "red"), bg = "gray")



haberman = read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/haberman/haberman.data", header = FALSE)
names(haberman) = c('age', 'op_year', 'no_nodes', 'survival')
str(haberman)

haberman$survival = factor(haberman$survival)
str(haberman)

h = glm(survival ~ age + op_year + no_nodes, data = haberman, family = binomial)
coef(h)

deviance(h)


# 새로운 환자 두 명
new_patients = data.frame(age = c(37, 66), op_year = c(58, 60), no_nodes = c(5, 32)) 
predict(h, newdata = new_patients, type = 'response')

h = glm(survival ~ age + no_nodes, data = haberman, family = binomial)
coef(h)

deviance(h)

new_patients = data.frame(age = c(37, 66), no_nodes = c(5, 32)) # 새로운 환자 두 명
predict(h, newdata = new_patients, type = 'response')



# 04 로지스틱 회귀의 적용 : UCLA admission 데이터 #
ucla = read.csv('https://stats.idre.ucla.edu/stat/data/binary.csv')
str(ucla)

library(dplyr)
library(ggplot2)
ucla %>% ggplot(aes(gre, admit)) + geom_point()   
ucla %>% ggplot(aes(gre, admit)) + geom_jitter()  
ucla %>% ggplot(aes(gre, admit)) + geom_jitter(aes(col = admit))
ucla %>% ggplot(aes(gre, admit)) + geom_jitter(aes(col = factor(admit)))
ucla %>% ggplot(aes(gre, admit)) + geom_jitter(aes(col = factor(admit)), height = 0.1, width = 0.0)   


install.packages('gridExtra')
library(gridExtra)
p1 = ucla%>%ggplot(aes(gpa, admit)) + geom_jitter(aes(col = factor(admit)), height = 0.1, width = 0.0)
p2 = ucla%>%ggplot(aes(rank, admit)) + geom_jitter(aes(col = factor(admit)), height = 0.1, width = 0.1)
grid.arrange(p1, p2, ncol = 2)

m = glm(admit~., data = ucla, family = binomial)
coef(m)
deviance(m,type='response')
summary(ucla)

s = data.frame(gre = c(376), gpa = c(3.6), rank = c(3))
predict(m, newdata = s, type ='response')

# 05 로지스틱 회귀의 적용 : colon 데이터 #
library(survival)
str(colon)

p1 = colon %>% ggplot(aes(extent, status)) + geom_jitter(aes(col = factor(status)), height = 0.1, width = 0.1)
p2 = colon %>% ggplot(aes(age, status)) + geom_jitter(aes(col = factor(status)), height = 0.1, width = 0.1)
p3 = colon %>% ggplot(aes(sex, status)) + geom_jitter(aes(col = factor(status)), height = 0.1, width = 0.1)
p4 = colon %>% ggplot(aes(nodes, status)) + geom_jitter(aes(col = factor(status)), height = 0.1, width = 0.1)

m = glm(status~., data = colon, family = binomial)
m

deviance(m)

table(is.na(colon))

clean_colon = na.omit(colon)
m = glm(status~., data = clean_colon, family = binomial)
m

deviance(m)


clean_colon = clean_colon[c(TRUE, FALSE), ]	           # 홀수 번째 것만 취함
m = glm(status~rx + sex + age + obstruct + perfor + adhere + nodes + differ + extent + surg + node4, data = clean_colon, family = binomial)
m

