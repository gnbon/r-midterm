# 1. diamond 데이터셋은 ggplot2 패키지에 있는 데이터셋이다.
# dplyr와 ggplot2 패키지의 함수들을 이용하여 아래의 분석과제를 수행하는 R코드를 작성하라.
library(ggplot2)
help(diamonds)
dia = diamonds
str(dia)
summary(dia)

dia %>% ggplot(aes(carat, price, col = clarity)) + geom_point()
dia %>% ggplot(aes(carat, price, col = cut)) + geom_point()
dia %>% ggplot(aes(carat, price, col = color)) + geom_point() + geom_smooth()

# 참고: https://rpubs.com/ameilij/EDA_lesson3

# 2.'2021.서울기상관측데이터.csv' 를 강의자료실에서 읽어들인 후, 아래 모델링을 수행하라.
setwd("~/workspace/R/final")
weather = read.csv("2021.서울기상관측데이터.csv", encoding = "UTF-8")

# 2-1) 일강수량을 예측하는 회귀모델링을 진행한 후, 적합된 모델의 회귀식을 쓰시오.
library(scatterplot3d)
scatterplot3d(trees$Girth, trees$Height, trees$Volume)

m = lm(Volume ~ Girth + Height, data=trees)
m
# 회귀식: Volume = 4.7082*Girth + 0.3393*Height - 57.9877

# 2-2) 수립된 회귀모델의 통계량을 summary() 함수로 출력하여 간략히 분석하라.
summary(m)

Call:
  lm(formula = Volume ~ Girth + Height, data = trees)

Residuals:
  Min      1Q  Median      3Q     Max 
-6.4065 -2.6493 -0.2876  2.2003  8.4847 

Coefficients:
  Estimate Std. Error t value Pr(>|t|)    
(Intercept) -57.9877     8.6382  -6.713 2.75e-07 ***
  Girth         4.7082     0.2643  17.816  < 2e-16 ***
  Height        0.3393     0.1302   2.607   0.0145 *  
  ---
  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 3.882 on 28 degrees of freedom
Multiple R-squared:  0.948,	Adjusted R-squared:  0.9442 
F-statistic:   255 on 2 and 28 DF,  p-value: < 2.2e-16

1. Residuals: 훈련 집합에 대한 잔차들의 summary 결과
2. Coefficients: Estimate)매개변수 Pr)p-value
lm()은 기본적으로 독립변수Girth, Height와 종속변수Volume는 아무 관련이 없다고 가정하는데,
p-value는 이 가정이 사실일 경우 주어진 데이터와 같은 정도의 값들이 나올 확률을 의미하므로
유의수준 0.05보다 Girth는 적으므로 두 변수간의 모델은 통계적으로 유의미
Height은 크므로 통계적으로 두 변수 간의 연관성은 우연이며 통계적으로 무의미

residuals(m)

# 3. UCLA admission 데이터셋을 읽어들인 후 아래 모델링을 수행하라.
ucla = read.csv("https://stats.idre.ucla.edu/stat/data/binary.csv")
ucla$admit = factor(ucla$admit)

summary(ucla)
# 3-1) 합격여부(admit)를 에측하는 랜덤포리스트 모델을 수립한 후, 결과의 OOB 데이터로부터 나온 혼동행렬을 기술하고 정확률을 구하라.
library(randomForest)
f = randomForest(admit~., data=ucla)
f

OOB estimate of  error rate: 28.25%
Confusion matrix:
    0  1 class.error
0 257 16  0.05860806
1  97 30  0.76377953

정확률은 (257 + 30)/400 = 71.75%

# 3-2) 구축된 랜덤포리스트 모델에서 중요한 변수들은 어떤 것들인지 살펴보고, 그 결과를 간단히 기술하라.
varUsed(f)
# 두 번째 설명변수인 gpa가 질문에 가장 많이 사용되었고, 세 번째 설명변수 rank가 질문에 가장 적게 사용되었음
varImpPlot(f)
# 해당 특징이 불순도를 얼마나 감소시키는가에 대한 지표인 MeanDecreaseGini에 대해서도 gpa 설명변수가 가장 높게 측정되었고, rank 설명변수가 가장 낮게 측정되었다.

# 4. 다음은 inspect(dtm)을 수행한 결과이다.
> inspect(dtm)
<<DocumentTermMatrix (documents: 3000, terms: 37300)>>
Non-/sparse entries: 299646/111600354
Sparsity           : 100%
Maximal term length: 50
Weighting          : term frequency (tf)
Sample             :
  Terms
Docs   even film good just like movie one really story time
1146    3   13    0    2    0     0   2      0     1    2
1296    3    6    5    6    9    14   4      1     0    1
131     3    7   11    2    3     5   3      1     1    2
1879    1    1    1    0    1     0   2      1     0    4
1943    1    9    6    0    5     2   0      2     2    1
2064    2    0    1    2    3     0   6      0     0    4
2193    1    9    4    1    1     0   6      0     2    1
2619    0    3    1    1    0     3   2      0     0    0
475     0    6    4    0    0     6   3      6     0    1
548     8    5    3    2    3     1   6      1     1    1

# 4-1) 출력결과를 간단히 해설하라.
1. dtm에는 문서가 3000개, 단어는 37300개 포함되어 있음
2. Non-/sparse entries에서 3000*37300개의 칸 중에서 299646개는 빈도가 있고, 111600354개는 0임
3. 따라서 전체에서 0이 차지하는 비율인 sparsity는 100%
sample term에서 예를 들면, 1146번 문서에는 even 단어가 3개, film 단어가 13개, ...포함되어 있음

# 4-2) 데이터 마이닝에서 이러한 DTM 은 왜 만드는가? 이유를 간단히 설명하라.
1. 비정형의 텍스트 데이터는 그 상태로는 시각화 함수를 적용할 수 없고 모델링할 수도 없기 때문
2. 텍스트 데이터를 함수에 적용하려면 일정한 크기의 벡터로 변환해야 하기 때문
3. DTM은 텍스트 문서를 일정한 크기의 벡터로 변환하기 위해 사용
4. 문서에 나타난 빈도를 표현하여 유사성을 측정할 수 있으므로 랜덤 포레스트나 SVM 등을 사용하여 문서를 분류 모델링 할 수 있다.