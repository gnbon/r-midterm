# 01-02 ���� #


# 03 �������� #

x = 5
y = 2
x/y
xi = 1 + 2i
yi = 1 - 2i
xi+yi
str = "Hello, World!"
str

blood.type = factor(c('A', 'B', 'O', 'AB'))
blood.type
T
F
xinf = Inf
yinf = -Inf
xinf/yinf


x = 1 		# x�� �ܼ��� 1�� ���� ��� x�� ������
x
is.integer(x)
x = 1L 		# x�� 1L�� �Է��� ��� x�� ������
x
is.integer(x)
x = as.integer(1) 	# x�� 1�� as.integer �Լ��� ��ȯ�Ͽ� �Է��� ��� x�� ������
x
is.integer(x)


# 05 ���� #
1:7 		# 1���� 7���� 1�� �������� ��Ұ� 7���� ���� ����
7:1 		# 7���� 1���� 1�� ���ҽ��� ��Ұ� 7���� ���� ����
vector(length = 5)
c(1:5)	 	# 1~5 ��ҷ� ������ ���� ����. 1:5�� ����
c(1, 2, 3, c(4:6)) 	# 1~3 ��ҿ� 4~6 ��Ҹ� ������ 1~6 ��ҷ� ������ ���� ����
x = c(1, 2, 3) 	# 1~3 ��ҷ� ������ ���͸� x�� ����
x 		# x ���
y = c() 		# y�� �� ���ͷ� ����
y = c(y, c(1:3)) 	# ���� y ���Ϳ� c(1:3) ���͸� �߰��� ����
y 		# y ���
seq(from = 1, to = 10, by = 2) 	# 1���� 10���� 2�� �����ϴ� ���� ����
seq(1, 10, by = 2) 			# 1���� 10���� 2�� �����ϴ� ���� ����
seq(0, 1, by = 0.1) 			# 0���� 1���� 0.1�� �����ϴ� ��Ұ� 11���� ���� ����
seq(0, 1, length.out = 11) 		# 0���� 1���� ��Ұ� 11���� ���� ����
rep(c(1:3), times = 2)		# (1, 2, 3) ���͸� 2�� �ݺ��� ���� ����
rep(c(1:3), each = 2) 		# (1, 2, 3) ������ ���� ��Ҹ� 2�� �ݺ��� ���� ����
x = c(2, 4, 6, 8, 10)
length(x) 		# x ������ ����(ũ��)�� ����
x[1] 		# x ������ 1�� ��� ���� ����
x[1, 2, 3] 		# x ������ 1, 2, 3�� ��Ҹ� ���� �� �̷��� �Է��ϸ� ����
x[c(1, 2, 3)] 	# x ������ 1, 2, 3�� ��Ҹ� ���� ���� ���ͷ� ����� ��
x[-c(1, 2, 3)] 	# x ���Ϳ��� 1, 2, 3�� ��Ҹ� ������ �� ���
x[c(1:3)] 		# x ���Ϳ��� 1������ 3�� ��Ҹ� ���
x = c(1, 2, 3, 4)
y = c(5, 6, 7, 8)
z = c(3, 4)
w = c(5, 6, 7)
x+2 		# x ������ ���� ��ҿ� 2�� ���� ����
x + y 		# x ���Ϳ� y ������ ũ�Ⱑ �����ϹǷ� �� ��Һ��� ����
x + z 		# x ���Ͱ� z ���� ũ���� �������� ��쿣 ���� �� ���� ��Ҹ� ��ȯ�ϸ� ����
x + w 		# x�� w�� ũ�Ⱑ �����谡 �ƴϹǷ� ���� ����
x >5 		# x ������ ��� ���� 5���� ū�� Ȯ��
all(x>5) 		# x ������ ��� ���� ��� 5���� ū�� Ȯ��
any(x>5) 		# x ������ ��� �� �� �Ϻΰ� 5���� ū�� Ȯ��
x = 1:10
head(x) 		# �������� �� 6�� ��Ҹ� ����
tail(x) 		# �������� �� 6�� ��Ҹ� ����
head(x, 3) 	# �������� �� 3�� ��Ҹ� ����
tail(x, 3) 		# �������� �� 3�� ��Ҹ� ����

x = c(1, 2, 3)
y = c(3, 4, 5)
z = c(3, 1, 2)
union(x, y) 	# ������
intersect(x, y) 	# ������
setdiff(x, y) 	# ������(x���� y�� ������ ��� ����)
setdiff(y, x) 	# ������(y���� x�� ���� ��� ����)
setequal(x, y) 	# x�� y�� ������ ��Ұ� �ִ��� ��
setequal(x, z) 	# x�� z�� ������ ��Ұ� �ִ��� ��



# 06 ��� #
# N���� �迭 ����
x = array(1:5, c(2, 4)) # 1~5 ���� 2�� 4 ��Ŀ� �Ҵ�
x
x[1, ] # 1�� ��� �� ���
x[, 2] # 2�� ��� �� ���
dimnamex = list(c("1st", "2nd"), c("1st", "2nd", "3rd", "4th")) # ��� �� �̸� ����
x = array(1:5, c(2, 4), dimnames = dimnamex)
x
x["1st", ]
x[, "4th"]
# 2���� �迭 ����
x = 1:12
x
matrix(x, nrow = 3)
matrix(x, nrow = 3, byrow = T)
# ���͸� ���� �迭 ����
v1 = c(1, 2, 3, 4)
v2 = c(5, 6, 7, 8)
v3 = c(9, 10, 11, 12)
cbind(v1, v2, v3) # �� ������ ���� �迭 ����
rbind(v1, v2, v3) # �� ������ ���� �迭 ����
# [ǥ 3-7]�� �����ڸ� Ȱ���� �پ��� ��� ����
# 2��2 ��� 2���� ���� x, y�� ����
x = array(1:4, dim = c(2, 2))
y = array(5:8, dim = c(2, 2))
x
y
x + y
x - y
x * y # �� ���� ����
x %*% y # �������� ��� ����
t(x) # x�� ��ġ ���
solve(x) # x�� �����
det(x) # x�� ��Ľ�
x = array(1:12, c(3, 4))
x
apply(x, 1, mean) # ��� ���� 1�̸� �Լ��� �ະ�� ����
apply(x, 2, mean) # ��� ���� 2�̸� �Լ��� ������ ����
x = array(1:12, c(3, 4))
dim(x)
x = array(1:12, c(3, 4))
sample(x) # �迭 ��Ҹ� ���Ƿ� ���� ����
sample(x, 10) # �迭 ��� �� 10���� ��� ����
sample(x, 10, prob = c(1:12)/24) # �� ��Һ� ���� Ȯ���� �޸��� �� ����
sample(10) # �ܼ��� ���ڸ� ����Ͽ� ������ ���� �� ����



# 07 ������ ������ #
name = c("ö��", "����", "�浿")
age = c(22, 20, 25)
gender = factor(c("M", "F", "M"))
blood.type = factor(c("A", "O", "B"))
patients = data.frame(name, age, gender, blood.type)
patients

# ������ ���� �� ������ �ۼ��� ���� ����
patients1 = data.frame(name = c("ö��", "����", "�浿"), age = c(22, 20, 25), gender = factor(c("M", "F", "M")), blood.type = factor(c("A", "O", "B")))
patients1
patients$name # name �Ӽ� �� ���
patients[1, ] # 1�� �� ���
patients[, 2] # 2�� �� ���
patients[3, 1] # 3�� 1�� �� ���
patients[patients$name=="ö��", ] # ȯ�� �� ö���� ���� ���� ����
patients[patients$name=="ö��", c("name", "age")] # ö�� �̸��� ���� ������ ����
head(cars) # cars ������ �� Ȯ��. head �Լ��� �⺻ ����� �� 6�� �����͸� ������
speed
attach(cars) # attach �Լ��� ���� cars�� �� �Ӽ��� ������ �̿��ϰ� ��
speed # speed��� �������� ���� �̿��� �� ����.
detach(cars) # detach �Լ��� ���� cars�� �� �Ӽ��� ������ ����ϴ� ���� ������
speed # speed��� ������ �����غ�����, �ش� ������ ����.
# ������ �Ӽ��� �̿��� �Լ� ����
mean(cars$speed)
max(cars$speed)
# with �Լ��� �̿��� �Լ� ����
with(cars, mean(speed))
with(cars, max(speed))
# �ӵ��� 20 �ʰ��� �����͸� ����
subset(cars, speed > 20)

# �ӵ��� 20 �ʰ��� dist �����͸� ����, ���� �� ������ c( ) ���� ,�� ����
subset(cars, speed > 20, select = c(dist))
# �ӵ��� 20 �ʰ��� ������ �� dist�� ������ �����͸� ����
subset(cars, speed > 20, select = -c(dist))
head(airquality) # airquality �����Ϳ��� NA�� ���ԵǾ� ����
head(na.omit(airquality)) # NA�� ���Ե� ���� �����Ͽ� ������
merge(x, y, by = intersect(names(x), names(y)), by.x = by, by.y = by, all = FALSE, all.x = all, all.y = all, sort = TRUE, suffixes = c(".x",".y"), incomparables = NULL, ...)E

name = c("ö��", "����", "�浿")
age = c(22, 20, 25)
gender = factor(c("M", "F", "M"))
blood.type = factor(c("A", "O", "B"))
patients1 = data.frame(name, age, gender)
patients1

patients2 = data.frame(name, blood.type)
patients2

patients = merge(patients1, patients2, by = "name")
patients

# �̸��� ���� �� ������ ���ٸ�, merge �Լ��� by.x�� by.y�� ��ĥ ��
# ����� ���� �Ӽ����� ���� �������־�� ��
name1 = c("ö��", "����", "�浿")
name2 = c("�μ�", "����", "�浿")
age = c(22, 20, 25)
gender = factor(c("M", "F", "M"))
blood.type = factor(c("A", "O", "B"))
patients1 = data.frame(name1, age, gender)
patients1

patients2 = data.frame(name2, blood.type)
patients2

patients = merge(patients1, patients2, by.x = "name1", by.y = "name2")
patients

patients = merge(patients1, patients2, by.x = "name1", by.y = "name2", all = TRUE)
patients
x = array(1:12, c(3, 4))
is.data.frame(x) # ���� x�� ������ �������� �ƴ�
as.data.frame(x)

# is.data.frame �Լ��� ȣ���ϴ� �͸����� x�� ������ ���������� �ٲ��� ����
is.data.frame(x)
# as.data.frame �Լ��� x�� ������ ������ �������� ��ȯ
x = as.data.frame(x)
x
# x�� ������ ������ �������� ��ȯ�Ǿ����� Ȯ��
is.data.frame(x)
# ������ ���������� ��ȯ �� �ڵ� �����Ǵ� �� �̸��� names �Լ��� ��������
names(x) = c("1st", "2nd", "3rd", "4th")
x


# 08 ����Ʈ #
patients = data.frame(name = c("ö��", "����", "�浿"), age = c(22, 20, 25), gender = factor(c("M", "F", "M")), blood.type = factor(c("A", "O", "B")))
no.patients = data.frame(day = c(1:6), no = c(50, 60, 55, 52, 65, 58))


# �����͸� �ܼ� �߰�
listPatients = list(patients, no.patients) 
listPatients


# �� �����Ϳ� �̸��� �ο��ϸ鼭 �߰� 
listPatients = list(patients=patients, no.patients = no.patients) 
listPatients

listPatients$patients		# ��Ҹ� �Է�

listPatients[[1]]				# �ε��� �Է�

listPatients[["patients"]]			# ��Ҹ��� ""�� �Է�

listPatients[["no.patients"]]		# ��Ҹ��� ""�� �Է�


# no.patients ����� ����� ������
lapply(listPatients$no.patients, mean) 

# patients ����� ����� ������. ���� ���°� �ƴ� ���� ����� �������� ����
lapply(listPatients$patients, mean) 

sapply(listPatients$no.patients, mean) 

# sapply()�� simplify �ɼ��� F�� �ϸ� lapply() ����� ������ ����� ��ȯ��
sapply(listPatients$no.patients, mean, simplify = F) 