# 02 DTM ���� #
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


# 03 �ܾ� ���� #
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


d1 = d[1:200, ]        # 200�� �ܾ ǥ��
wordcloud2(d1, shape = 'star')
wordcloud2(d1, minRotation = pi/4, maxRotation = pi/4, rotateRatio = 1.0)


findFreqTerms(dtm, lowfreq = 12)

findAssocs(dtm, terms = 'harvard', corlimit = 0.7)

barplot(d[1:10, ]$freq, las = 2, names.arg = d[1:10,]$word, col = 'lightblue', main = '�߻� �� ���� �ܾ�', ylab = '�ܾ� ��')

library(gapminder)
library(dplyr)

pop_siz = gapminder%>%filter(year==2007)%>%group_by(continent)%>%summarize(sum(as.numeric(pop)))
d = data.frame(word = pop_siz[, 1], freq = pop_siz[, 2])
wordcloud(words = d[, 1], freq = d[, 2], min.freq = 1, max.words = 100, random.order = FALSE, rot.per = 0.35)
wordcloud2(d)


# 04 ���� �з� #

library(text2vec)
library(caret)

str(movie_review)

head(movie_review)

# �����͸� �Ʒ� ����(mtrain)�� �׽�Ʈ ����(mtest)�� ����
train_list = createDataPartition(y= movie_review$sentiment, p = 0.6, list =  FALSE)
mtrain = movie_review[train_list, ]
mtest = movie_review[-train_list, ]


# �Ʒ� �������� DTM ����
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


# �Ʒ� �������� DTM ����
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


# 05 ���� �ؽ�Ʈ ���̴��� �̿��� �ѱ��� ó�� #

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
d1 = d[1:500, ]                # 500�� �ܾ ǥ��
wordcloud2(d1)



# 06 KoNLP�� �̿��� �ѱ��� �ؽ�Ʈ ���̴� #

install.packages('KoNLP')
library(KoNLP)
useSystemDic()
useSejongDic()
useNIADic()


useSejongDic()
s='�ʿ��� ���´� ��ź�� �Ժη� �߷� ���� ���� �ʴ� �������� �ѹ��̶� �߰ſ� ����̾�����'
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

wordcloud2(v)             # ��� �ܾ� ǥ�� : [�׸� 11-14(a)]
v1 = v[1:100]              # ���� 100�� �ܾ ��� ǥ�� : [�׸� 11-14(b)]
wordcloud2(v1)

# [�� �˾ƺ���] Ʈ���� API�� �̿��� ����ġ ��� #
library(twitteR)
# �Ʒ� ������ Ű �� ��� ����ڰ� ������ ������ 4���� Ű�� �Է�!
consumerKey = "twEhTjcTtzJSUYqnewJp8fQgm"
consumerSecret = "nJIcd0ldPlZiTpUey8oLFGPxyjkDReZl5aSkPVvPtXfwUhowXS"
accessToken = "67037524gWk67HzUfJnSoYJbZAuyqak62SxzfnYp4X2pWzNG6"
accessTokenSecret = "nWmXO2UT6pm6I0ZrizBwE94bOrdUJIsrt3pBCBSKbI4B0"

setup_twitter_oauth(consumerKey, consumerSecret, accessToken, accessTokenSecret)
keyword <- enc2utf8("�̼�����")
twitdata <- searchTwitter(keyword, n=100, lang="ko")
twitdata_df <- twListToDF(twitdata)
twitdata_text = twitdata_df$text
twitdata_text