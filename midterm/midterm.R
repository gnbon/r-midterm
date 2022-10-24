# 3. airquality

# 파생변수 생성 및 특정조건 데이터 출력, 결측치 평균값으로 대체하기
# (이상값 평균값으로 대체하기!)
airquality_re = airquality

airquality_re$Ozone = ifelse(is.na(airquality_re$Ozone)==T, mean(airquality_re$Ozone, na.rm=T), airquality_re$Ozone)
airquality_re$Solar.R = ifelse(is.na(airquality_re$Solar.R)==T, mean(airquality_re$Solar.R, na.rm=T), airquality_re$Solar.R)

# 4. gapminder

# Oceania 대륙 국가들의 연도에 따른 1인당 GDP 추이를 분석해보려 한다.
gapminder_oceania = gapminder %>%
  filter(continent == 'Oceania')
ggplot(data=gapminder_oceania, aes(x=year, y=gdpPercap, col=factor(country))) +
  geom_line()


# 대륙별로 gdp 당 평균기대수명 구하고 대륙별로 색깔 다르게 해서 선 그래프 그리기
ggplot(data=gapminder, aes(x=gdpPercap, y=lifeExp, col=factor(continent))) +
  geom_line() +
  scale_x_log1()

# 아프리카 대륙에서 2007년도 기준으로 평균기대수명이 60세 이상인 나라들만 추출하여 국가당 1인당 gdb가 한눈에 쉽게 비교될 수 있도록 시각화
gapminder_africa = gapminder %>%
  filter(continent == 'Africa' & year == 2007 & lifeExp >= 60)

ggplot(data=gapminder_africa, aes(x=country, y=gdpPercap, col=factor(country))) +
  geom_col()

## 5. mpg

#  자동차 출시년도와 구동방식에 따라 어떤 차종이 통합연비 평균 제일 좋은지
# 순서대로 구하고 막대그래프 그리기 ??
library(ggplot2)
library(dplyr)
mpg1 = mpg %>%
  group_by(year, trans) %>%
  mutate(total=(cty+hwy)/2)

ggplot(data=mpg, aes)

# 제조사별로 도시와 고속도로 연비의 평균인 통합연비 변수를 추가하여,
# 배기량에 따른 통합연비의 변화추세가 제조사별로 쉽게 비교되도록 시각화하기.
mpg1 = mpg %>%
  group_by(manufacturer) %>%
  mutate(total=(cty+hwy)/2)

ggplot(data=mpg1, aes(x=displ, y=total, col=factor(manufacturer))) +
geom_point()


## 3. airquality 데이터셋에 대해 Base R의 명령어만 이용하여 아래 명령을 수행하는 코드를 작성하라. (이번 문제는 dplyr를 사용하지 말 것)

### 파생변수 생성 및 특정조건 데이터 출력, 결측치 평균값으로 대체하기(이상값 평균값으로 대체하기!)

### 파생변수 빈도수 출력, 평균기온 산출

## 4. gapminder데이터에서 Oceania 대륙 국가들의 연도에 따른 1인당 GDP 추이를 분석해보려 한다.  dplyr와 ggplot2 패키지를 활용하여 코드를 작성하라.


### 대륙별로 gdp 별 평균기대수명 구하고 대륙별로 색깔 다르게 해서 선 그래프 그리기


### 아프리카 대륙에서 2007년도 기준으로 평균기대수명이 60세 이상인 나라들만 추출하여 국가당 1인당 gdb가 한눈에 쉽게 비교될 수 있도록 시각화

## 5. mpg 데이터셋에 대해 dplyr와 ggplot2 패키지를 활용하여 코드를 작성하라.

- 자동차 출시년도와 구동방식에 따라 어떤 차종이 통합연비 평균 제일 좋은지 순서대로 구하고 막대그래프 그리기
- 제조사별로 도시와 고속도로 연비의 평균인 통합연비 변수를 추가하여, 배기량에 따른 통합연비의 변화추세가 제조사별로 쉽게 비교되도록 시각화하기.