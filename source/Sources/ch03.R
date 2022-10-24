# 01-02 생략 #


# 03 데이터형 #

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


x = 1 		# x에 단순히 1을 넣은 경우 x는 숫자형
x
is.integer(x)
x = 1L 		# x에 1L을 입력한 경우 x는 정수형
x
is.integer(x)
x = as.integer(1) 	# x에 1을 as.integer 함수로 변환하여 입력한 경우 x는 정수형
x
is.integer(x)


# 05 벡터 #
1:7 		# 1부터 7까지 1씩 증가시켜 요소가 7개인 벡터 생성
7:1 		# 7부터 1까지 1씩 감소시켜 요소가 7개인 벡터 생성
vector(length = 5)
c(1:5)	 	# 1~5 요소로 구성된 벡터 생성. 1:5와 동일
c(1, 2, 3, c(4:6)) 	# 1~3 요소와 4~6 요소를 결합한 1~6 요소로 구성된 벡터 생성
x = c(1, 2, 3) 	# 1~3 요소로 구성된 벡터를 x에 저장
x 		# x 출력
y = c() 		# y를 빈 벡터로 생성
y = c(y, c(1:3)) 	# 기존 y 벡터에 c(1:3) 벡터를 추가해 생성
y 		# y 출력
seq(from = 1, to = 10, by = 2) 	# 1부터 10까지 2씩 증가하는 벡터 생성
seq(1, 10, by = 2) 			# 1부터 10까지 2씩 증가하는 벡터 생성
seq(0, 1, by = 0.1) 			# 0부터 1까지 0.1씩 증가하는 요소가 11개인 벡터 생성
seq(0, 1, length.out = 11) 		# 0부터 1까지 요소가 11개인 벡터 생성
rep(c(1:3), times = 2)		# (1, 2, 3) 벡터를 2번 반복한 벡터 생성
rep(c(1:3), each = 2) 		# (1, 2, 3) 벡터의 개별 요소를 2번 반복한 벡터 생성
x = c(2, 4, 6, 8, 10)
length(x) 		# x 벡터의 길이(크기)를 구함
x[1] 		# x 벡터의 1번 요소 값을 구함
x[1, 2, 3] 		# x 벡터의 1, 2, 3번 요소를 구할 때 이렇게 입력하면 오류
x[c(1, 2, 3)] 	# x 벡터의 1, 2, 3번 요소를 구할 때는 벡터로 묶어야 함
x[-c(1, 2, 3)] 	# x 벡터에서 1, 2, 3번 요소를 제외한 값 출력
x[c(1:3)] 		# x 벡터에서 1번부터 3번 요소를 출력
x = c(1, 2, 3, 4)
y = c(5, 6, 7, 8)
z = c(3, 4)
w = c(5, 6, 7)
x+2 		# x 벡터의 개별 요소에 2를 각각 더함
x + y 		# x 벡터와 y 벡터의 크기가 동일하므로 각 요소별로 더함
x + z 		# x 벡터가 z 벡터 크기의 정수배인 경우엔 작은 쪽 벡터 요소를 순환하며 더함
x + w 		# x와 w의 크기가 정수배가 아니므로 연산 오류
x >5 		# x 벡터의 요소 값이 5보다 큰지 확인
all(x>5) 		# x 벡터의 요소 값이 모두 5보다 큰지 확인
any(x>5) 		# x 벡터의 요소 값 중 일부가 5보다 큰지 확인
x = 1:10
head(x) 		# 데이터의 앞 6개 요소를 추출
tail(x) 		# 데이터의 뒤 6개 요소를 추출
head(x, 3) 	# 데이터의 앞 3개 요소를 추출
tail(x, 3) 		# 데이터의 뒤 3개 요소를 추출

x = c(1, 2, 3)
y = c(3, 4, 5)
z = c(3, 1, 2)
union(x, y) 	# 합집합
intersect(x, y) 	# 교집합
setdiff(x, y) 	# 차집합(x에서 y와 동일한 요소 제외)
setdiff(y, x) 	# 차집합(y에서 x와 동일 요소 제외)
setequal(x, y) 	# x와 y에 동일한 요소가 있는지 비교
setequal(x, z) 	# x와 z에 동일한 요소가 있는지 비교



# 06 행렬 #
# N차원 배열 생성
x = array(1:5, c(2, 4)) # 1~5 값을 2× 4 행렬에 할당
x
x[1, ] # 1행 요소 값 출력
x[, 2] # 2열 요소 값 출력
dimnamex = list(c("1st", "2nd"), c("1st", "2nd", "3rd", "4th")) # 행과 열 이름 설정
x = array(1:5, c(2, 4), dimnames = dimnamex)
x
x["1st", ]
x[, "4th"]
# 2차원 배열 생성
x = 1:12
x
matrix(x, nrow = 3)
matrix(x, nrow = 3, byrow = T)
# 벡터를 묶어 배열 생성
v1 = c(1, 2, 3, 4)
v2 = c(5, 6, 7, 8)
v3 = c(9, 10, 11, 12)
cbind(v1, v2, v3) # 열 단위로 묶어 배열 생성
rbind(v1, v2, v3) # 행 단위로 묶어 배열 생성
# [표 3-7]의 연산자를 활용한 다양한 행렬 연산
# 2×2 행렬 2개를 각각 x, y에 저장
x = array(1:4, dim = c(2, 2))
y = array(5:8, dim = c(2, 2))
x
y
x + y
x - y
x * y # 각 열별 곱셈
x %*% y # 수학적인 행렬 곱셈
t(x) # x의 전치 행렬
solve(x) # x의 역행렬
det(x) # x의 행렬식
x = array(1:12, c(3, 4))
x
apply(x, 1, mean) # 가운데 값이 1이면 함수를 행별로 적용
apply(x, 2, mean) # 가운데 값이 2이면 함수를 열별로 적용
x = array(1:12, c(3, 4))
dim(x)
x = array(1:12, c(3, 4))
sample(x) # 배열 요소를 임의로 섞어 추출
sample(x, 10) # 배열 요소 중 10개를 골라 추출
sample(x, 10, prob = c(1:12)/24) # 각 요소별 추출 확률을 달리할 수 있음
sample(10) # 단순히 숫자만 사용하여 샘플을 만들 수 있음



# 07 데이터 프레임 #
name = c("철수", "춘향", "길동")
age = c(22, 20, 25)
gender = factor(c("M", "F", "M"))
blood.type = factor(c("A", "O", "B"))
patients = data.frame(name, age, gender, blood.type)
patients

# 다음과 같이 한 행으로 작성할 수도 있음
patients1 = data.frame(name = c("철수", "춘향", "길동"), age = c(22, 20, 25), gender = factor(c("M", "F", "M")), blood.type = factor(c("A", "O", "B")))
patients1
patients$name # name 속성 값 출력
patients[1, ] # 1행 값 출력
patients[, 2] # 2열 값 출력
patients[3, 1] # 3행 1열 값 출력
patients[patients$name=="철수", ] # 환자 중 철수에 대한 정보 추출
patients[patients$name=="철수", c("name", "age")] # 철수 이름과 나이 정보만 추출
head(cars) # cars 데이터 셋 확인. head 함수의 기본 기능은 앞 6개 데이터를 추출함
speed
attach(cars) # attach 함수를 통해 cars의 각 속성을 변수로 이용하게 함
speed # speed라는 변수명을 직접 이용할 수 있음.
detach(cars) # detach 함수를 통해 cars의 각 속성을 변수로 사용하는 것을 해제함
speed # speed라는 변수에 접근해보지만, 해당 변수가 없음.
# 데이터 속성을 이용해 함수 적용
mean(cars$speed)
max(cars$speed)
# with 함수를 이용해 함수 적용
with(cars, mean(speed))
with(cars, max(speed))
# 속도가 20 초과인 데이터만 추출
subset(cars, speed > 20)

# 속도가 20 초과인 dist 데이터만 추출, 여러 열 선택은 c( ) 안을 ,로 구분
subset(cars, speed > 20, select = c(dist))
# 속도가 20 초과인 데이터 중 dist를 제외한 데이터만 추출
subset(cars, speed > 20, select = -c(dist))
head(airquality) # airquality 데이터에는 NA가 포함되어 있음
head(na.omit(airquality)) # NA가 포함된 값을 제외하여 추출함
merge(x, y, by = intersect(names(x), names(y)), by.x = by, by.y = by, all = FALSE, all.x = all, all.y = all, sort = TRUE, suffixes = c(".x",".y"), incomparables = NULL, ...)E

name = c("철수", "춘향", "길동")
age = c(22, 20, 25)
gender = factor(c("M", "F", "M"))
blood.type = factor(c("A", "O", "B"))
patients1 = data.frame(name, age, gender)
patients1

patients2 = data.frame(name, blood.type)
patients2

patients = merge(patients1, patients2, by = "name")
patients

# 이름이 같은 열 변수가 없다면, merge 함수의 by.x와 by.y에 합칠 때
# 사용할 열의 속성명을 각각 기입해주어야 함
name1 = c("철수", "춘향", "길동")
name2 = c("민수", "춘향", "길동")
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
is.data.frame(x) # 현재 x는 데이터 프레임이 아님
as.data.frame(x)

# is.data.frame 함수를 호출하는 것만으로 x가 데이터 프레임으로 바뀌지 않음
is.data.frame(x)
# as.data.frame 함수로 x를 데이터 프레임 형식으로 변환
x = as.data.frame(x)
x
# x가 데이터 프레임 형식으로 변환되었음을 확인
is.data.frame(x)
# 데이터 프레임으로 변환 시 자동 지정되는 열 이름을 names 함수로 재지정함
names(x) = c("1st", "2nd", "3rd", "4th")
x


# 08 리스트 #
patients = data.frame(name = c("철수", "춘향", "길동"), age = c(22, 20, 25), gender = factor(c("M", "F", "M")), blood.type = factor(c("A", "O", "B")))
no.patients = data.frame(day = c(1:6), no = c(50, 60, 55, 52, 65, 58))


# 데이터를 단순 추가
listPatients = list(patients, no.patients) 
listPatients


# 각 데이터에 이름을 부여하면서 추가 
listPatients = list(patients=patients, no.patients = no.patients) 
listPatients

listPatients$patients		# 요소명 입력

listPatients[[1]]				# 인덱스 입력

listPatients[["patients"]]			# 요소명을 ""에 입력

listPatients[["no.patients"]]		# 요소명을 ""에 입력


# no.patients 요소의 평균을 구해줌
lapply(listPatients$no.patients, mean) 

# patients 요소의 평균을 구해줌. 숫자 형태가 아닌 것은 평균이 구해지지 않음
lapply(listPatients$patients, mean) 

sapply(listPatients$no.patients, mean) 

# sapply()의 simplify 옵션을 F로 하면 lapply() 결과와 동일한 결과를 반환함
sapply(listPatients$no.patients, mean, simplify = F) 
