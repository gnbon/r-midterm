# 02 DTM 구축 #
library(RCurl)
library(XML)

t = readLines('https://en.wikipedia.org/wiki/Data_science')
d = htmlParse(t, asText = TRUE)
clean_doc = xpathSApply(d,"//p", xmlValue)


library(tm)
library(SnowballC)

doc = Corpus(VectorSource(clean_doc))
inspect(doc)

doc = tm_map(doc, content_transformer(tolower))
doc = tm_map(doc, removeNumbers)
doc = tm_map(doc, removeWords, stopwords('english'))
doc = tm_map(doc, removePunctuation)
doc = tm_map(doc, stripWhitespace)


dtm = DocumentTermMatrix(doc)
dim(dtm)


inspect(dtm)


# 03 단어 구름 #
library(wordcloud)

m = as.matrix(dtm)
v = sort(colSums(m), decreasing = TRUE)
d = data.frame(word = names(v), freq = v)
wordcloud(words = d$word, freq = d$freq, min.freq = 1, max.words = 100, random.order = FALSE, rot.per = 0.35)

library(RColorBrewer)

pal = brewer.pal(11,"Spectral")
wordcloud(words = d$word, freq = d$freq, min.freq = 1, max.words = 50, random.order = FALSE, rot.per = 0.50, colors = pal)
wordcloud(words = d$word, freq = d$freq, min.freq = 1, max.words = 50, random.order = FALSE, rot.per = 0.50, colors = pal, family = "mono", font = 2)


library(wordcloud2)
wordcloud2(d)


d1 = d[1:200, ]        # 200개 단어만 표시
wordcloud2(d1, shape = 'star')
wordcloud2(d1, minRotation = pi/4, maxRotation = pi/4, rotateRatio = 1.0)


findFreqTerms(dtm, lowfreq = 12)

findAssocs(dtm, terms = 'harvard', corlimit = 0.7)

barplot(d[1:10, ]$freq, las = 2, names.arg = d[1:10,]$word, col = 'lightblue', main = '발생 빈도 상위 단어', ylab = '단어 빈도')

library(gapminder)
library(dplyr)

pop_siz = gapminder%>%filter(year==2007)%>%group_by(continent)%>%summarize(sum(as.numeric(pop)))
d = data.frame(word = pop_siz[, 1], freq = pop_siz[, 2])
wordcloud(words = d[, 1], freq = d[, 2], min.freq = 1, max.words = 100, random.order = FALSE, rot.per = 0.35)
wordcloud2(d)


# 04 문서 분류 #

library(text2vec)
library(caret)

str(movie_review)

head(movie_review)

# 데이터를 훈련 집합(mtrain)과 테스트 집합(mtest)로 나눔
train_list = createDataPartition(y= movie_review$sentiment, p = 0.6, list =  FALSE)
mtrain = movie_review[train_list, ]
mtest = movie_review[-train_list, ]


# 훈련 집합으로 DTM 구축
doc = Corpus(VectorSource(mtrain$review))
doc = tm_map(doc, content_transformer(tolower))
doc = tm_map(doc, removeNumbers)
doc = tm_map(doc, removeWords, stopwords('english'))
doc = tm_map(doc, removePunctuation)
doc = tm_map(doc, stripWhitespace)
dtm = DocumentTermMatrix(doc)
dim(dtm)
str(dim)
inspect(dtm)


dtm_small = removeSparseTerms(dtm, 0.90)
X = as.matrix(dtm_small)
dataTrain = as.data.frame(cbind(mtrain$sentiment, X))
dataTrain$V1 = as.factor(dataTrain$V1)
colnames(dataTrain)[1] = 'y'


library(rpart)
r = rpart(y~., data = dataTrain)
printcp(r)
par(mfrow = c(1, 1), xpd = NA)
plot(r)
text(r, use.n = TRUE)

library(randomForest)
f = randomForest(y~., data = dataTrain)


# 훈련 집합으로 DTM 구축
docTest = Corpus(VectorSource(mtest$review))
docTest = tm_map(docTest, content_transformer(tolower))
docTest = tm_map(docTest, removeNumbers)
docTest = tm_map(docTest, removeWords, stopwords('english'))
docTest = tm_map(docTest, removePunctuation)
docTest = tm_map(docTest, stripWhitespace)

dtmTest = DocumentTermMatrix(docTest, control=list(dictionary=dtm_small$dimnames$Terms))

dim(dtmTest)
str(dtmTest)
inspect(dtmTest)


X = as.matrix(dtmTest)
dataTest = as.data.frame(cbind(mtest$sentiment, X))
dataTest$V1 = as.factor(dataTest$V1)
colnames(dataTest)[1] = 'y'
pr = predict(r, newdata = dataTest, type = 'class')
table(pr, dataTest$y)

pf = predict(f, newdata = dataTest)
table(pf, dataTest$y)


# 05 영어 텍스트 마이닝을 이용한 한국어 처리 #

library(tm)
library(XML)
library(wordcloud2)
library(SnowballC)
library(RCurl)
t = readLines('https://ko.wikipedia.org/wiki/%EB%B9%85_%EB%8D%B0%EC%9D%B4%ED%84%B0')
d = htmlParse(t, asText = TRUE)
clean_doc = xpathSApply(d, "//p", xmlValue)


doc = Corpus(VectorSource(clean_doc))
inspect(doc)

doc = tm_map(doc, content_transformer(tolower))
doc = tm_map(doc, removeNumbers)
doc = tm_map(doc, removePunctuation)
doc = tm_map(doc, stripWhitespace)

dtm = DocumentTermMatrix(doc)
dim(dtm)
inspect(dtm)


m = as.matrix(dtm)
v = sort(colSums(m), decreasing = TRUE)
d = data.frame(word = names(v), freq = v)
d1 = d[1:500, ]                # 500개 단어만 표시
wordcloud2(d1)



# 06 KoNLP를 이용한 한국어 텍스트 마이닝 #

install.packages('KoNLP')
library(KoNLP)
useSystemDic()
useSejongDic()
useNIADic()


useSejongDic()
s='너에게 묻는다 연탄재 함부로 발로 차지 마라 너는 누구에게 한번이라도 뜨거운 사람이었느냐'
extractNoun(s)

SimplePoss22(s)


t=readLines('https://ko.wikipedia.org/wiki/%EB%B9%85_%EB%8D%B0%EC%9D%B4%ED%84%B0')
d=htmlParse(t, asText=TRUE)
clean_doc=xpathSApply(d, "//p", xmlValue)


useSejongDic()

nouns = extracNoun(clean_doc)
mnous = unlist(nouns)
mnous_freq = table(mnous)
v = sort(mnous_freq, decreasing = TRUE)

wordcloud2(v)             # 모든 단어 표시 : [그림 11-14(a)]
v1 = v[1:100]              # 상위 100개 단어만 골라 표시 : [그림 11-14(b)]
wordcloud2(v1)

# [더 알아보기] 트위터 API를 이용한 말뭉치 얻기 #
library(twitteR)
# 아래 임의의 키 값 대신 사용자가 실제로 생성한 4개의 키를 입력!
consumerKey = "twEhTjcTtzJSUYqnewJp8fQgm"
consumerSecret = "nJIcd0ldPlZiTpUey8oLFGPxyjkDReZl5aSkPVvPtXfwUhowXS"
accessToken = "67037524gWk67HzUfJnSoYJbZAuyqak62SxzfnYp4X2pWzNG6"
accessTokenSecret = "nWmXO2UT6pm6I0ZrizBwE94bOrdUJIsrt3pBCBSKbI4B0"

setup_twitter_oauth(consumerKey, consumerSecret, accessToken, accessTokenSecret)
keyword <- enc2utf8("미세먼지")
twitdata <- searchTwitter(keyword, n=100, lang="ko")
twitdata_df <- twListToDF(twitdata)
twitdata_text = twitdata_df$text
twitdata_text
