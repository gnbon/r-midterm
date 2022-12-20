install.packages("RCurl")
install.packages("XML")

library(RCurl) # no need
library(XML)

t = readLines('https://en.wikipedia.org/wiki/Data_science')
d = htmlParse(t, asText=TRUE)
clean_doc = xpathSApply(d, "//p", xmlValue)

install.packages("tm")
install.packages("SnowballC")

# dtm
library(tm)
library(SnowballC) # no need

doc = Corpus(VectorSource(clean_doc))
inspect(doc)
doc = tm_map(doc, content_transformer(tolower))
inspect(doc)
doc = tm_map(doc, removeNumbers)
doc = tm_map(doc, removeWords, stopwords('english'))
doc = tm_map(doc, removePunctuation)
doc = tm_map(doc, stripWhitespace)

dtm = DocumentTermMatrix(doc)
dim(dtm)
inspect(dtm)

# 단어 구름
install.packages("wordcloud2")
library(wordcloud2)

m = as.matrix(dtm)
v = sort(colSums(m), decreasing=T)
d = data.frame(word = names(v), freq = v)
wordcloud2(d)

# 영화평 분류
install.packages("text2vec")
library(text2vec)
library(caret)

str(movie_review)
head(movie_review)

# 데이터를 훈련 집합(mtrain)과 테스트 집합(mtest)로 나눔
train_list = createDataPartition(y=movie_review$sentiment, p = 0.6, list=FALSE)
mtrain=movie_review[train_list, ]
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

inspect(dtm)

dtm_small = removeSparseTerms(dtm, 0.90)
dim(dtm_small)
inspect(dtm_small)

X = as.matrix(dtm_small)
dataTrain = as.data.frame(cbind(mtrain$sentiment, X))
dataTrain$V1 = as.factor(dataTrain$V1)
colnames(dataTrain)[1] = 'y'

library(rpart)
r = rpart(y~., dataTrain)
printcp(r)

library(rpart.plot)
rpart.plot(r, extra=1)

library(randomForest)
f = randomForest(y~., dataTrain)

docTest = Corpus(VectorSource(mtest$review))
docTest = tm_map(docTest, content_transformer(tolower))
docTest = tm_map(docTest, removeNumbers)
docTest = tm_map(docTest, removeWords, stopwords('english'))
docTest = tm_map(docTest, removePunctuation)
docTest = tm_map(docTest, stripWhitespace)

dtmTest = DocumentTermMatrix(docTest, control = list(dictionary=dtm_small$dimnames$Terms))
dim(dtmTest)
str(dtmTest)
inspect(dtmTest)

X = as.matrix(dtmTest)
dataTest = as.data.frame(cbind(mtest$sentiment, X))
dataTest$V1 = as.factor(dataTest$V1)
colnames(dataTest)[1] = 'y'
pr =predict(r, newdata=dataTest, type='class')
table(pr, dataTest$y)
pf=predict(f, newdata=dataTest)
table(pf, dataTest$y)

