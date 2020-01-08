library(stringr)
library(tm)
library(KoNLP)
library(wordcloud2)

#벅스 정제 작업(2010년도) - 연도별로 작업
b2010 <- readLines('c:/data/2010년대가사(벅스).txt')
head(b2010)

#지워야할 글자 
# 처음 X
# 마지막 '가사 오류 제보'
# 가사 끝 '아이디 님이 등록해주신 가사입니다.'
# 청소년 보호법 가사 삭제
# 준비중 가사 삭제
b2010 <- str_replace_all(b2010,' \\w+ 님이 등록해 주신 가사입니다. 가사 오류 제보 $', '')

b2010[grep('청소년 보호법', b2010)] <- NA
b2010[grep('가사 준비', b2010)] <- NA
b2010 <- na.omit(b2010)

corp1_b2010 <- VCorpus(VectorSource(b2010))
summary(corp1_b2010)
inspect(corp1_b2010)
corp1_b2010[[1]]$content
corp2_b2010 <- tm_map(corp1_b2010, removeNumbers)
corp2_b2010 <- tm_map(corp2_b2010, removePunctuation)

useSejongDic()

ko.words <- function(doc){
  d <- as.character(doc)
  s <- SimplePos22(d)
  a <- as.vector(na.omit(str_match(s, '([A-z가-힣]+)/NC')[,2]))
  unique(a)
}

stop_w <- c('날','널','때','속','니','니가','이젠','앞','위','우린','곳','안','뒤','내겐','그댈','밖','애',
            '옆','어','그때','m','t','라')

tdm_b2010 <- TermDocumentMatrix(corp2_b2010, control=list(tokenize=ko.words, wordLengths=c(1,Inf),
                                              stopwords=stop_w))

m_b2010 <- as.matrix(tdm_b2010)
wc_b2010 <- sort(rowSums(m_b2010), decreasing=T)

head(wc_b2010, 100)
aa <- wc_b2010[wc_b2010>1]

wordcloud2(data.frame(names(aa),aa))

