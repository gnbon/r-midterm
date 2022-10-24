library(gapminder)
library(dplyr)
library(ggplot2)

# ----- midwest ----- #

# county, state, poptotal, popasian 속성 추출
midwest1 = midwest %>%
  select(county, state, poptotal, popasian)

# poptotal을 total로, popasian을 asian으로 속성 이름 수정
midwest1 = midwest1 %>%
  rename(total=poptotal, asian=popasian)

# total과 asian 변수를 이용해 전체 인구 대비 아시아 인구 백분율을 나타내는
# 속성 pct_asian을 추가
midwest1 = midwest1 %>% 
  mutate(pct_asian = asian/total*100)

# 아시아 인구비율의 분포가 어느 정도인지 확인
hist(midwest1$pct_asian)

# 해당 도시의 pct_asian이 전체 도시의 pct_asian의 평균을 초과하면 "large",
# 평균 이하면 "small"을 추가하는 속성 degree를 추가
midwest1 = midwest1 %>%
  mutate(degree = ifelse(pct_asian>mean(pct_asian), "large", "small"))
  
# "large"와 "small"에 해당하는 지역이 얼마나 되는지 그래프로 확인
# barploat에는 table이 들어가야 함
midwest1$degree
table(midwest1$degree)
barplot(table(midwest1$degree))

str(midwest1)  
head(midwest1)

# ----- mpg ----- #

# 제조사별로 "suv" 자동차들의 통합연비 평균을 구한 후 내림차순으로 정렬하여
# 1~5위까지 출력
mpg %>%
  group_by(manufacturer) %>%
  filter(class == "suv") %>%
  mutate(total = (cty+hwy)/2) %>%
  summarise(mean_tot=mean(total)) %>%
  arrange(desc(mean_tot)) %>%
  head(5)  
  
# "audi"와 "toyota" 중 어느 제조사의 도시연비가 평균적으로 더 높은가?
mpg %>%
  filter(manufacturer == "audi" | manufacturer == "toyota") %>%
  group_by(manufacturer) %>%
  summarise(avg=mean(cty)) %>%
  arrange(desc(avg))

# 어떤 제조사가 "copact" 차종을 가장 많이 생산하는가?
mpg %>%
  filter(class == "compact") %>%
  group_by(manufacturer) %>%
  summarise(count=n()) %>%
  arrange(desc(count))