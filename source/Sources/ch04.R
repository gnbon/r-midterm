# 01 ���� �а� ���� #

# ���� ������ �࿡�� [Enter]�� ������ ���� ���
students = read.table("C:/Sources/students.txt", header = T) 

# ���� ������ �࿡�� [Enter]�� ���� ���
students = read.table("C:/Sources/students.txt",  header = T) 
students

# ���� ������ ���� Ȯ��
str(students) 

# ������ �ִ� ���� �״�� ����
students = read.table("C:/Sources/students.txt", header = T, as.is = T) 
str(students)

# ������ ���� �� ������ �������� �ν����� �ʵ��� ����
students = read.table("C:/Sources/students.txt", header = T, stringsAsFactors = F) 
str(students)

# ���� ��ȣ�� ��ǥ(,), ù ���� header�� �ν��Ͽ� ������ �ִ� �״�� �о���̸� 
# NA�� ���� math ��Ұ� �������� �νĵ�
students = read.table("C:/Sources/students.txt", sep = ",", header = T, as.is = T) 
str(students)

# "NA" ������ ������ NA�� ó���϶�� �ص� ó���� �ȵ�. ��Ȯ�� ������ NA �տ� �� ĭ�� �־�� �ϱ� ����
students = read.table("C:/Sources/students.txt", sep = ",", header = T, as.is = T, na.strings = "NA")  
str(students)

# "NA"�� ��Ȯ�ϰ� �Է����� ������ NA�� ó���Ǹ鼭 math ��Ұ� ��� ���ڷ� �νĵ�
students = read.table("C:/Sources/students.txt", sep = ",", header = T, as.is = T, na.strings = " NA") 
str(students)

# strip.white���� ��ĭ�� �����ϸ� na.string�� �⺻���� "NA"�� �����Ǿ� math ��Ұ� ��� ���ڷ� �νĵ�.
students = read.table("C:/Sources/students.txt", sep = ",", header = T, as.is = T, strip.white = T) 
str(students)

# ù ���� header�̹Ƿ� header �ɼ��� ������ �ʿ䰡 ����
students = read.csv("C:/Sources/students.csv") 
students

# ���� ������ ���� Ȯ��
str(students) 

# name �Ӽ��� ���ο��� �������� ����
students$name = as.character(students$name) 
str(students)

# ������ ���� �� ������ �������� �ν����� �ʵ��� ������
students = read.csv("C:/Sources/students.csv", stringsAsFactors = FALSE) 
str(students)

students = read.table("C:/Sources/students.txt", header = T, as.is = T)

# ���忡 ū����ǥ�� ǥ�õ�.
write.table(students, file = "C:/Sources/output.txt") 

# ���忡 ū����ǥ���� ����.
write.table(students, file = "C:/Sources/output.txt", quote = F) 


# 02 ������ ������ ���� ���ǹ��� �ݺ��� #

test = c(15, 20, 30, NA, 45)	# ������ ���
test[test<40]	# ���� 40 �̸��� ��� ����

test[test%%3!= 0]	# ���� 3���� ������ �������� �ʴ� ��� ����


test[is.na(test)]	# NA�� ��� ����


test[!is.na(test)]			# NA�� �ƴ� ��� ����

test[test%%2==0&!is.na(test)]	# 2�� ����鼭 NA�� �ƴ� ��� ����

characters = data.frame(name = c("�浿", "����", "ö��"), age = c(30, 16, 21), gender = factor(c("M", "F","M")))  # ������ �������� ���

characters
                        
                      
characters[characters$gender =="F",]  # ������ ������ �� ����
                
characters[characters$age<30&characters$gender =="M",] # 30�� �̸��� ���� �� ����                    
                        

x = 5
if(x %% 2 ==0) {
print('x�� ¦��')	# ���ǽ��� ���� �� ����
}   else {
print('x�� Ȧ��')	# ���ǽ��� ������ �� ����
}

x = -1
if(x>0) {
  print('x is a positive value.')	# x�� 0���� ũ�� ���
} else if(x<0) {
  print('x is a negative value.')	# �� ������ �������� �ʰ� x�� 0���� ������ ���
} else {
  print('x is zero.')		# �� ������ ��� �������� ������ ���
}


x = c(-5:5)
options(digits = 3)		# ���� ǥ�� �� ��ȿ�ڸ����� 3�ڸ��� ����
sqrt(x)


sqrt(ifelse(x>=0, x, NA))	# NaN�� �߻����� �ʰ� ������ NA�� ǥ��

students = read.csv("C:/Sources/students.csv")
students 	     # �����Ϳ� 100 �ʰ� ���� ���� ���� ���ԵǾ� ����.

students[, 2] = ifelse(students[, 2]>= 0 & students[, 2]<= 100, students[, 2], NA)
students[, 3] = ifelse(students[, 3]>= 0 & students[, 3]<= 100, students[, 3], NA)
students[, 4] = ifelse(students[, 4]>= 0 & students[, 4]<= 100, students[, 4], NA)
students 	     # ifelse ������ 2~4�� �� �� 0~100 ���� ���� NA�� ó����.

                        
# repeat ���� �̿��� 1���� 10���� ���� ������Ű��
i = 1	             # i�� ���۰��� 1
repeat {
  if(i>10) {         # i�� 10�� ������ �ݺ��� �ߴ�(break)��
    break
  } else {
    print(i)
    i = i+1           # i�� 1 ������Ŵ.
  }
}



# while ���� �̿��� 1���� 10���� ���� ������Ű��
i = 1 # i�� ���۰��� 1��.
while(i <= 10){ # i�� 10 ������ ���ȿ� �ݺ���
  print(i)
  i = i+1 # i�� 1 ������Ŵ.
}


# while ���� �̿��� ������ 2�� �����
i = 1
while(i<10) {
  print(paste(2, "X", i, "=", 2*i))
  i = i+1
}

# for ���� �̿��� 1���� 10���� ���� ������Ű��
for(i in 1:10) {
  print(i)
}  

# for ���� �̿��� ������ 2�� �����
for(i in 1:9) {
  print(paste(2, "X", i, "=", 2*i))
}

# for ���� �̿��� ������ 2~9�� �����
for(i in 2:9) {
  for(j in 1:9) {
    print(paste(i, "X", j, "=", i*j))
  }
}

# 1���� 10������ �� �� ¦���� ����ϱ�
for(i in 1:10) {
  if(i%%2 == 0) {
    print(i)
  }
}

# 1���� 10������ �� �� �Ҽ� ����ϱ�
for(i in 1:10) {
  check = 0
  for(j in 1:i) {
    if(i%%j ==0) {
      check = check+1
    }
  }
  if(check ==2) { 
    print(i)
  }
}

students = read.csv("C:/Sources/students.csv")
students	    # �����Ϳ� 100 �ʰ� ���� ���� ���� ���ԵǾ� ����


for(i in 2:4) {
  students[, i] = ifelse(students[, i]>= 0 & students[, i]<= 100, students[, i], NA)
}


students	    # ifelse ������ 2~4�� �� �� 0~100 ���� ���� NA�� ó����


# 03 ����� ���� �Լ� : ���ϴ� ��� ���� # 

fact = function(x) {   # �Լ��� �̸��� fact, �Է��� x
  fa = 1  # ��°��� ������ ����
  while(x>1) {  # x�� 1���� ū ���� �ݺ�
    fa = fa*x   # x ���� fa�� ���� �� fa�� �ٽ� ����
    x = x-1  # x ���� 1 ����
  }  
  return(fa)   # ���� ���� fa ��ȯ
}
fact(5)	  # 5!�� ����� ��� ���


my.is.na<-function(x) {	# table(is.na()) �Լ��� �ϳ��� ���� my.is.na �Լ��� ����
  table(is.na(x))
}

my.is.na(airquality)	# �� ����� table(is.na(airquality))�� ����.


table(is.na(airquality))


# 04 ������ ���� ���� 1 : ������ ó�� # 

# is.na �Լ��� �̿��� ������ ó���ϱ�
str(airquality)	# airquality �������� ������ ���캽.

# airquality �����Ϳ��� NA�� ���� TRUE, �ƴϸ� FALSE�� ��Ÿ��. �����Ͱ� ���� head �Լ��� �߷���.
head(is.na(airquality))	
table(is.na(airquality))	# NA�� �� 44�� ����.

table(is.na(airquality$Temp))	# Temp���� NA�� ������ Ȯ����.

table(is.na(airquality$Ozone))	# Ozone���� NA�� 37�� �߰ߵ�.

mean(airquality$Temp)		# NA�� ���� Temp�� ����� ������.

mean(airquality$Ozone)		# NA�� �ִ� Ozone�� ����� NA�� ����.

air_narm = airquality[!is.na(airquality$Ozone), ] # Ozone �Ӽ����� NA�� ���� ���� ������. 
air_narm
mean(air_narm$Ozone)	# �������� ���ŵ� �����Ϳ����� mean �Լ��� ���������� ������.

# na.omit �Լ��� �̿��� ������ ó���ϱ�
air_narm1 = na.omit(airquality)
mean(air_narm1$Ozone)

# �Լ� �Ӽ��� na.rm�� �̿��� ������ ó���ϱ�
mean(airquality$Ozone, na.rm = T)


table(is.na(airquality))

table(is.na(airquality$Ozone))

table(is.na(airquality$Solar.R))

air_narm = airquality[!is.na(airquality$Ozone) & !is.na(airquality$Solar.R), ]
mean(air_narm$Ozone)


# 05 ������ ���� ���� 2 : �̻� ó�� # 

# �̻��� ���Ե� ȯ�� ������
patients = data.frame(name = c("ȯ��1", "ȯ��2", "ȯ��3", "ȯ��4", "ȯ��5"), age = c(22, 20, 25, 30, 27), gender=factor(c("M", "F", "M", "K", "F")), blood.type = factor(c("A", "O", "B", "AB", "C")))
patients

# �������� �̻� ����
patients_outrm = patients[patients$gender=="M"|patients$gender=="F", ]
patients_outrm	


# ������ ���������� �̻� ����
patients_outrm1 = patients[(patients$gender == "M"|patients$gender == "F") & (patients$blood.type == "A"|patients$blood.type == "B"|patients$blood.type == "O"|patients$blood.type == "AB"), ]
patients_outrm1	 

# �̻��� ���Ե� ȯ�� ������
patients = data.frame(name = c("ȯ��1", "ȯ��2", "ȯ��3", "ȯ��4", "ȯ��5"), age = c(22, 20, 25, 30, 27), gender = c(1, 2, 1, 3, 2), blood.type = c(1, 3, 2, 4, 5))
patients	

# ������ �ִ� �̻��� ���������� ����
patients$gender = ifelse((patients$gender<1|patients$gender>2), NA, patients$gender)
patients	

# �������� �ִ� �̻󰪵� ���������� ����
patients$blood.type = ifelse((patients$blood.type<1|patients$blood.type>4), NA, patients$blood.type)
patients

# �������� ��� ����
patients[!is.na(patients$gender)&!is.na(patients$blood.type), ]

boxplot(airquality[, c(1:4)])    # Ozone, Solar.R, Wind, Temp�� ���� boxplot
boxplot(airquality[, 1])$stats   # Ozone�� boxplot ��谪 ���

air = airquality                 # �ӽ� ���� ������ airquality ������ ����
table(is.na(air$Ozone))          # Ozone�� ���� NA ���� Ȯ��

# �̻��� NA�� ����
air$Ozone = ifelse(air$Ozone<1|air$Ozone>122, NA, air$Ozone) 
table(is.na(air$Ozone)) # �̻� ó�� �� NA ���� Ȯ��(2�� ����)

# NA ����
air_narm = air[!is.na(air$Ozone), ] 
mean(air_narm$Ozone) # �̻� �� �� ���ŷ� is.na �Լ��� �̿��� ������� ���� �پ��