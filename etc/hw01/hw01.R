# hw01.R #

# 1. csv 파일 읽어오기

# getwd()로 확인한 작업디렉토리에 파일을 넣고 실습
getwd()

# 문자열->범주형으로 변환, 인코딩은 euc-kr로 csv 파일 읽어오기
workers = read.csv('2018년_근로자휴가조사(근로자).csv', stringsAsFactors=T, fileEncoding='euc-kr')

# 2. 데이터 파악

# 구조 파악
class(workers)
str(workers)

# 지역, 업종 열을 범주형으로 변경
for (i in 1:2) {
  workers[, i] = as.factor(workers[, i])
}

# 성별, 학력, 직업 열을 범주형으로 변경
for (i in 7:9) {
  workers[, i] = as.factor(workers[, i])
}

# 연차휴가사용 열을 정수형으로 변경
workers$연차휴가사용 = as.integer(workers$연차휴가사용)

# 내용 파악
head(workers)
View(workers)

# 분포 확인

# 양적 변수 요약
for (i in 1:10) {
  if (is.integer(workers[, i])) {
    print(names(workers[i]))
    print(summary(workers[, i]))
  }
}

# 범주 변수 요약
for (i in 1:10) {
  if (is.factor(workers[, i])) {
    print(names(workers[i]))
    print(table(workers[, i]))
  }
}

# 결측값 체크
table(is.na(workers))
table(is.na(workers$연차휴가부여)) # 5
table(is.na(workers$연차휴가사용)) # 9
table(is.na(workers$연차휴가부여) & is.na(workers$연차휴가사용)) # 4(중복)

# 3. 데이터 정제

# 결측값 제거
workers_narm = workers[!is.na(workers$연차휴가부여) & !is.na(workers$연차휴가사용), ]

# 결측값 존재 여부와 정제된 데이터 구조 파악
table(is.na(workers_narm))
str(workers_narm)

# 4. 데이터 분석

# 패키지 부착
library(dplyr)

# 1
for (i in 1:10) { # workers_narm의 10개 열에 대하여
  if (is.factor(workers_narm[, i])) { # 범주 변수인지 검사
    print(workers_narm %>%
      group_by(workers_narm[i]) %>% # 범주 변수별로
      summarise(연차휴가부여=mean(연차휴가부여), 연차휴가사용=mean(연차휴가사용))) # 연차휴가부여 평균과 연차휴가사용 평균을 비교
  }
}

# 2
workers_narm %>%
  filter(연령대=='20대' | 연령대=='30대') %>% # 20~30대 행을 추출하여
  select(학력) %>% # 학력 열을 추출하고
  table() # 분포 확인

workers_narm %>%
  filter(연령대=='40대' | 연령대=='50대' | 연령대=='60대') %>% # 40~60대 행을 추출하여
  select(학력) %>% # 학력 열을 추출하고
  table() # 분포 확인

# 3
workers_narm %>%
  filter(사업체규모>1&사업체규모<=3) %>% # 사업체규모가 1~3인 행을 추출하여
  group_by(성별) %>% # 성별로 분류하고
  summarise(월평균소득구간=mean(월평균소득구간)) # 월평균소득구간의 평균 비교

workers_narm %>%
  filter(사업체규모>4&사업체규모<=6) %>% # 사업체규모가 4~6인 행을 추출하여
  group_by(성별) %>% # 성별로 분류하고
  summarise(월평균소득구간=mean(월평균소득구간)) # 월평균소득구간의 평균 비교
