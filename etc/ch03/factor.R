# c() : combine. 데이터 값 여러 개를 묶어 벡터 반환
sex = c('M', 'F', 'F', 'M', 'F')

sex
str(sex)

sex = factor(sex)
sex

# factor 형은 내부적으로 범주를 의미하는 숫자로 관리됨
str(sex)

class(sex)
typeof(sex)

is.factor(sex)