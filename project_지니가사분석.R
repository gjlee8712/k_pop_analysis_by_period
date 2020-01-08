library(stringr)
library(tm)
library(KoNLP)
library(wordcloud2)

#지니 정제 작업(2010년도) - 연도별로 작업
g2010 <- readLines('c:/data/2010년대가사(지니).txt')
head(g2010)

#지워야할 글자 
# 처음 ' 전체선택 프린트 '
# 마지막 ' 듣기 담기 다운로드 더보기 다운로드 선물하기 공유하기 오류신고하기 '
# 가사 앞 제목과 숫자 패턴 예) LUCIFER - 03:54
# 청소년 이용제한 가사 삭제
g2010 <- gsub(' 전체선택 프린트 ', ' ', g2010)
g2010 <- gsub(' 듣기 담기 다운로드 더보기 다운로드 선물하기 공유하기 오류신고하기 ', ' ', g2010)
head(g2010)

g2010 <- str_replace_all(g2010, '^.+\\:[0-9]{2,}', '')
g2010[grep('청소년 이용제한', g2010)] <- NA
g2010 <- na.omit(g2010)

corp1_g2010 <- VCorpus(VectorSource(g2010))
summary(corp1_g2010)
inspect(corp1_g2010)
corp1_g2010[[1]]$content
corp2_g2010 <- tm_map(corp1_g2010, removeNumbers)
corp2_g2010 <- tm_map(corp2_g2010, removePunctuation)

useSejongDic()
ko.words <- function(doc){
  d <- as.character(doc)
  s <- SimplePos22(d)
  a <- as.vector(na.omit(str_match(s, '([A-z가-힣]+)/NC')[,2]))
  unique(a)
}
stop_w <- c('날','널','때','속','니','니가','이젠','앞','위','우린','곳','안','뒤','내겐','그댈','밖','애',
            '옆','어','그때','m','t','라')
tdm_g2010 <- TermDocumentMatrix(corp2_g2010, control=list(tokenize=ko.words, wordLengths=c(1,Inf), 
                                                          stopwords=stop_w))
m_g2010 <- as.matrix(tdm_g2010)
wc_g2010 <- sort(rowSums(m_g2010), decreasing=T)

head(wc_g2010, 100)
aa <- wc_g2010[wc_g2010>1]


wordcloud2(data.frame(names(aa),aa))

findAssocs(tdm_g2010, '사랑', 0.1)
findAssocs(tdm_g2010, '말', 0.1)
findAssocs(tdm_g2010, '눈', 0.1)
findAssocs(tdm_g2010, '오늘', 0.1)
findAssocs(tdm_g2010, '사람', 0.1)
