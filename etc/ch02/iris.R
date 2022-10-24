# 구조 파악/경향 파악/데이터 시각화
str(iris)
head(iris, 10)
plot(iris)

# $표현 사용하여 데이터셋 안의 특정 열 명시
iris$Petal.Length
iris$Species

# col에 row를 명시하여 level에 따라 다른 색상 지정
plot(iris$Petal.Width, iris$Petal.Length, col=iris$Species)