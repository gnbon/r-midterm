library(ggplot2)
library(dplyr)
library(gapminder)

# ----- gapminder ----- #

# 인구 변화의 추이를 대륙별로 묶어 관찰
y = gapminder %>%
  group_by(year, continent) %>%
  summarise(c_pop = sum(pop))

# 범례 개수를 데이터 개수에 맞게 작성
plot(y$year, y$c_pop, col=y$continent, pch = c(1:length(levels(y$continent))))
legend("topleft", 
    legend = levels((y$continent)), 
    pch = c(1:length(levels(y$continent))),
    col = c(1:length(levels(y$continent)))
)

# ----- mpg ----- #

# 배기량에 따른 고속도로 연비를 구동별로 시각화
ggplot(data=mpg, aes(x=displ, y=hwy, col=drv)) +
  geom_point()
# 얻을 수 있는 정보: 배기량이 많이질 수록 연비는 낮아짐
# 대체적으로 4륜 구동과 후륜 구동은 배기량은 많으며 연비는 낮고,
# 전륜 구동은 배기량은 낮으며 연비가 높음

# cyl은 정수형이므로 양적변수로 이해함
ggplot(data=mpg, aes(x=displ, y=hwy, col=cyl)) + 
  geom_point()

# cyl은 형식은 정수형이나 내용은 범주형이므로 factor() 사용
ggplot(data=mpg, aes(x=displ, y=hwy, col=factor(cyl))) +
  geom_point()

# 많은데이터에 대한 패턴 파악 -> geom_point()
ggplot(data=mpg, aes(x=displ, y=hwy, col=factor(cyl))) + 
  geom_point()

# 데이터의 추세 -> geom_line()
ggplot(data=mpg, aes(x=displ, y=hwy, col=factor(cyl))) + 
  geom_point()

# layer이므로 겹칠 수 있음
ggplot(data=mpg, aes(x=displ, y=hwy, col=factor(cyl))) + 
  geom_point() + geom_line()