# 03 �ܼ� ���� ȸ�� #

x = c(3.0, 6.0, 9.0, 12.0)	# ���� ���� x
y = c(3.0, 4.0, 5.5, 6.5)	# ���� ���� y
m = lm(y ~ x)		# �� ����(�н�)
m			# m ���


plot(x, y)
abline(m, col = 'red')

coef(m)       # �Ű�����(���) ���� �˷���
fitted(m)     # �Ʒ����տ� �ִ� ���ÿ� ���� ������
residuals(m)  # ������ �˷���
deviance(m)   # ���������ո� �˷���
deviance(m)/length(x) # ������������ ������������� ��ȯ�Ͽ� ���

summary(m)	# ���� �� �м�

newx = data.frame(x = c(1.2, 2.0, 20.65))	 # 3���� ���ο� ��
predict(m, newdata = newx)		 # ���� ����

nx=c(1.2,2.0,20.65)
ny=c(2.23,2.55,10.01)
plot(nx,ny,col='red', cex=2,pch=20)
abline(m)


# 04 �ܼ� ���� ȸ���� ���� : cars ������ #
str(cars)
head(cars)
plot(cars)


car_model = lm(dist~speed, data = cars)
coef(car_model)
abline(car_model, col = 'red')

fitted(car_model)
residuals(car_model)


nx1 = data.frame(speed = c(21.5))
predict(car_model, nx1)
nx2 = data.frame(speed = c(25.0, 25.5, 26.0, 26.5, 27.0, 27.5, 28.0))
predict(car_model, nx2)



nx = data.frame(speed = c(21.5, 25.0, 25.5, 26.0, 26.5, 27.0, 27.5, 28.0))
plot(nx$speed, predict(car_model, nx), col ='red', cex = 2, pch = 20)
abline(car_model)

plot(cars, xlab ='�ӵ�', ylab = '�Ÿ�')      # cars �����͸� �׸�
x = seq(0, 25, length.out = 200)            # ������ ����  
for(i in 1:4) {  
  m = lm(dist~poly(speed, i), data = cars)
  assign(paste('m', i, sep = '.'), m)        # i�� �� m�� m.i�� �θ�
  lines(x, predict(m, data.frame(speed = x)), col = i) # m���� ������ ����� ���� �׸� 
}

# �л� �м�
anova(m.1, m.2, m.3, m.4)                 


# 05 ���� ��跮 �ؼ� #
# women �����Ϳ� ����
str(women)
women


women_model = lm(weight ~ height, data = women)
coef(women_model)

plot(women)
abline(women_model, col = 'red')

summary(women_model)


car_model = lm(dist ~ speed, data = cars)
summary(car_model)


# 06 ���� ���� ȸ�� #

install.packages('scatterplot3d')
library(scatterplot3d)
x = c(3.0, 6.0, 3.0, 6.0)
u = c(10.0, 10.0, 20.0, 20.0)
y = c(4.65, 5.9, 6.7, 8.02)
scatterplot3d(x, u, y, xlim = 2:7, ylim = 7:23, zlim = 0:10, pch = 20, type = 'h')


m = lm(y ~ x + u)
coef(m)

s = scatterplot3d(x, u, y, xlim = 2:7, ylim = 7:23, zlim = 0:10, pch = 20, type = 'h')
s$plane3d(m)

fitted(m)
residuals(m) 
deviance(m)           # ���� ������
deviance(m)/length(x) # ��� ���� ����

nx = c(7.5, 5.0)
nu = c(15.0, 12.0)
new_data = data.frame(x = nx, u = nu)          
ny = predict(m, new_data)
ny


s = scatterplot3d(trees$Girth, trees$Height, trees$Volume, pch = 20, type = 'h', angle = 55)
s$plane3d(m)


# 07 ���� ���� ȸ���� ���� : trees ������ #
str(trees)
summary(trees)
scatterplot3d(trees$Girth, trees$Height, trees$Volume)
m = lm(Volume ~ Girth + Height, data = trees)
m
s = scatterplot3d(trees$Girth, trees$Height, trees$Volume, pch = 20, type = 'h', angle = 55)
s$plane3d(m)
ndata = data.frame(Girth = c(8.5, 13.0, 19.0), Height = c(72, 86, 85))
predict(m, newdata = ndata)

# [�� �˾ƺ���] t-������ �л� �м� #
# �� ������ ������
data1 = c(30, -5, 55, -30, -20, 45)
data2 = c(12, 13, 12, 13, 12, 13)
data3 = c(30, -5, 55, -30, -20, 45, 30, -5, 55, -30, -20, 45)
# ��հ� ǥ������
mean(data1)
sd(data1)
mean(data2)
sd(data2)
mean(data3)
sd(data3)
t.test(data1)
t.test(data2)
t.test(data3)
