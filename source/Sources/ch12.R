# 02 ������ ���� #
install.packages("stringr")
library(stringr)

# ������ �����͸� ������ �״�� �о����(factor�� ��ȯ ��Ȱ��ȭ)
x = read.csv("C:/Sources/googleplaystore.csv", header = TRUE, sep = ",", as.is = TRUE)

# Price�� ���Ե� $ ��ȣ�� ������
x$Price = str_replace(x$Price, '\\$', '')

# 10473���� ������ �׸� �� �Ϻΰ� �����Ǿ� ������
x = x[-10473, ]

# Size������ �� ��� ��Varies with device���� ǥ��� �����͸� NA�� ǥ����
# Mega byte�� �ǹ��ϴ� ���� M�� 10�� 6�������� ġȯ
# Kilo byte�� �ǹ��ϴ� ���� k�� 10�� 3�������� ġȯ
# Sys.setlocale('LC_ALL','C') 
x$Size = sub("Varies with device", NA, x$Size)     
x$Size = sub("M", "e6", x$Size, fixed = TRUE)
x$Size = sub("k", "e3", x$Size, fixed = TRUE)

# ���ڿ��� ��ȣ�� ó���� �� ���������� ������ �����ͷ� ��ȯ�� 
x$Size = as.numeric(x$Size)

# Installs ���� ��ϵ� ���ں��� �� ũ�ٴ� �ǹ��� + ��ȣ�� ���Ե� �������� 
# 1,000 ���� ���� ���п� ���Ǵ� ,�� ���Ե� �������� �����Ƿ� 
# str_replace �Լ��� ����� �� ���ڷ� ġȯ�Ͽ� ó���� 
x$Installs = str_replace(x$Installs, '\\+', '')
x$Installs = str_replace_all(x$Installs, ', ', '' )

# ���������� ��ȯ��. 
x$Installs = as.numeric(x$Installs)

# ������ ������ ���ڿ�, ��ȣ ���� ó�� �������� ���� �������� ������ 
x = na.omit(x)

# ������ ������ ������ �� �� ���� �׸��� ���������� �����Ͽ� �� ��ȯ�� ������
x$Category = as.factor(x$Category)
x$Reviews = as.numeric(x$Reviews)
x$Type = as.factor(x$Type)
x$Price = as.numeric(x$Price)
x$Content.Rating = as.factor(x$Content.Rating)
x$Genres = as.factor(x$Genres)

# ������ Date���� �ս��� ��ȯ�� ���� lubridate ���̺귯���� mdy �Լ��� �̿��� �� ���� 
library(lubridate)
x$Last.Updated = mdy(x$Last.Updated) 


library(dplyr)
glimpse(x)

View(x)


# 03 Ž���� ������ �м� #
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


# 04 �𵨸��� ���� #

# ���� ���� ȸ�� �м�
m = lm(Rating ~ Size + Content.Rating + Category, data = x)

# ���� ���� ��� Ȯ��
m

# mse ����
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

# ���� ������ ��� ����(�ּ� ǥ�õ� ��� ���� �߿��� �ϳ��� ���ʷ� �ּ��� �����Ͽ� �����Ѵ�.)
ps = select(x, Rating, Category)
#ps = select(x, Rating, Size)
#ps = select(x, Rating, Content.Rating)
#ps = select(x, Rating, Category, Size)
#ps = select(x, Rating, Category, Content.Rating)
#ps = select(x, Rating, Size, Content.Rating)
#ps = select(x, Rating, Category, Size, Content.Rating)



# ���� Ʈ�� ��
library(rpart)			# rpart ���̺귯�� 

r = rpart(Rating~., data = trainData)			# �� �н�
prd = predict(r, newdata = testData)			# �𵨿� ���� ����

# ���� ������Ʈ ��(���� ������Ʈ ���̺귯��)
library(randomForest)	# ���� ������Ʈ ���̺귯��

f = randomForest(Rating~., data = trainData)	# �� �н�
prd = predict(f, newdata = testData)	# �𵨿� ���� ����


# ���� ������Ʈ ��(SVM ���̺귯��)
library(e1071)		# SVM ���̺귯��

f = svm(Rating~., data = trainData)		# �� �н�
prd = predict(f, newdata = testData)		# �𵨿� ���� ����


# [�� �˾ƺ���] FAMILY ���� �뼼? #
x%>%group_by(Category, Genres)%>%summarise(n = n())%>%arrange(Category)%>%ggplot(aes(Category, Genres, size = n)) + geom_point() + theme(axis.text.y = element_text(size = 5), axis.text.x = element_text(size = 7, angle = -45, hjust = 0, vjust = 0))