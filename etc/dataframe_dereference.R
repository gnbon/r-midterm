# 데이터프레임은 벡터를 합친 것
name = c('철수', '춘향', '길동')
age = c(22, 20, 25)
gender = factor(c("M", "F", "M"))
blood.type = factor(c('A', 'B', 'O'))

# data.frame() 함수로 생성
patients = data.frame(name, age, gender, blood.type)

# $속성명과 [] 통해 요소 접근
patients$name
patients[1, 2]
patients[1, ]
patients[, 2]

# 비교/논리 연산자를 이용하여 조건을 구성하여 원하는 데이터만 필터링
patients[patients$name=='철수', ]
patients[patients$name=='철수', c(1, 2)]
patients[patients$name=='철수', c('name', 'blood.type')]

# 콤마를 빠트렸을 때 ...
# 콤마없이 숫자만 넣으면 열 번호를 의미
patients[patients$name=='철수']
patients$name=='철수'

# 다음 논리형 벡터와 동일한 결과
patients[c(T, F, F)]
