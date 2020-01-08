library(stringr)

#2010년대
#가사 정제
g2010 <- readLines('c:/data/2010년대가사(지니).txt')
head(g2010, 10)
g2010 <- gsub(' 전체선택 프린트 ', ' ', g2010)
g2010 <- gsub(' 듣기 담기 다운로드 더보기 다운로드 선물하기 공유하기 오류신고하기 ', ' ', g2010)
g2010[grep('청소년 이용제한', g2010)] <- NA
g2010 <- na.omit(g2010)
head(g2010, 10)

#제목 정제
g2010_s <- str_extract(g2010, '^.+?- [0-9]{2}:[0-9]{2} ')
g2010_s
g2010_s <- substr(g2010_s,2,nchar(g2010_s)-9)
g2010_s
g2010_s <- str_replace_all(g2010_s, '\\(.*?\\)','')
g2010_s


#가사 추가 정제
g2010 <- str_replace_all(g2010, '^.+?- [0-9]{2}:[0-9]{2} ','')
head(g2010)

g <- c()
for (i in 1:length(g2010_s)){
  g <- c(g, grep(g2010_s[i], g2010[i]))
}
g

p_2010 <- length(g)/length(g2010_s)


#2000년대
#가사 정제
g2000 <- readLines('c:/data/2000년대가사(지니).txt')
head(g2000, 10)
g2000 <- gsub(' 전체선택 프린트 ', ' ', g2000)
g2000 <- gsub(' 듣기 담기 다운로드 더보기 다운로드 선물하기 공유하기 오류신고하기 ', ' ', g2000)
g2000[grep('청소년 이용제한', g2000)] <- NA
g2000 <- na.omit(g2000)
head(g2000, 10)

#제목 정제
g2000_s <- str_extract(g2000, '^.+?- [0-9]{2}:[0-9]{2} ')
g2000_s
g2000_s <- substr(g2000_s,2,nchar(g2000_s)-9)
g2000_s
g2000_s <- str_replace_all(g2000_s, '\\(.*?\\)','')
g2000_s


#가사 추가 정제
g2000 <- str_replace_all(g2000, '^.+?- [0-9]{2}:[0-9]{2} ','')
head(g2000)

g <- c()
for (i in 1:length(g2000_s)){
  g <- c(g, grep(g2000_s[i], g2000[i]))
}
g

p_2000 <- length(g)/length(g2000_s)


#1990년대
#가사 정제
g1990 <- readLines('c:/data/1990년대가사(지니).txt')
head(g1990, 10)
g1990 <- gsub(' 전체선택 프린트 ', ' ', g1990)
g1990 <- gsub(' 듣기 담기 다운로드 더보기 다운로드 선물하기 공유하기 오류신고하기 ', ' ', g1990)
g1990[grep('청소년 이용제한', g1990)] <- NA
g1990 <- na.omit(g1990)
head(g1990, 10)

#제목 정제
g1990_s <- str_extract(g1990, '^.+?- [0-9]{2}:[0-9]{2} ')
g1990_s
g1990_s <- substr(g1990_s,2,nchar(g1990_s)-9)
g1990_s
g1990_s <- str_replace_all(g1990_s, '\\(.*?\\)','')
g1990_s


#가사 추가 정제
g1990 <- str_replace_all(g1990, '^.+?- [0-9]{2}:[0-9]{2} ','')
head(g1990)

g <- c()
for (i in 1:length(g1990_s)){
  g <- c(g, grep(g1990_s[i], g1990[i]))
}
g

p_1990 <- length(g)/length(g1990_s)


#1980년대
#가사 정제
g1980 <- readLines('c:/data/1980년대가사(지니).txt')
head(g1980, 10)
g1980 <- gsub(' 전체선택 프린트 ', ' ', g1980)
g1980 <- gsub(' 듣기 담기 다운로드 더보기 다운로드 선물하기 공유하기 오류신고하기 ', ' ', g1980)
g1980[grep('청소년 이용제한', g1980)] <- NA
g1980 <- na.omit(g1980)
head(g1980, 10)

#제목 정제
g1980_s <- str_extract(g1980, '^.+?- [0-9]{2}:[0-9]{2} ')
g1980_s
g1980_s <- substr(g1980_s,2,nchar(g1980_s)-9)
g1980_s
g1980_s <- str_replace_all(g1980_s, '\\(.*?\\)','')
g1980_s


#가사 추가 정제
g1980 <- str_replace_all(g1980, '^.+?- [0-9]{2}:[0-9]{2} ','')
head(g1980)

g <- c()
for (i in 1:length(g1980_s)){
  g <- c(g, grep(g1980_s[i], g1980[i]))
}
g

p_1980 <- length(g)/length(g1980_s)


#1970년대
#가사 정제
g1970 <- readLines('c:/data/1970년대가사(지니).txt')
head(g1970, 10)
g1970 <- gsub(' 전체선택 프린트 ', ' ', g1970)
g1970 <- gsub(' 듣기 담기 다운로드 더보기 다운로드 선물하기 공유하기 오류신고하기 ', ' ', g1970)
g1970[grep('청소년 이용제한', g1970)] <- NA
g1970 <- na.omit(g1970)
head(g1970, 10)

#제목 정제
g1970_s <- str_extract(g1970, '^.+?- [0-9]{2}:[0-9]{2} ')
g1970_s
g1970_s <- substr(g1970_s,2,nchar(g1970_s)-9)
g1970_s
g1970_s <- str_replace_all(g1970_s, '\\(.*?\\)','')
g1970_s


#가사 추가 정제
g1970 <- str_replace_all(g1970, '^.+?- [0-9]{2}:[0-9]{2} ','')
head(g1970)

g <- c()
for (i in 1:length(g1970_s)){
  g <- c(g, grep(g1970_s[i], g1970[i]))
}
g

p_1970 <- length(g)/length(g1970_s)



p <- rbind(p_1970, p_1980, p_1990, p_2000, p_2010)
p <- cbind(p, 1-p)
colnames(p) <- c('O','X')
p
pie(p[1,], labels=paste0(colnames(p),'\n',round(p[1,]*100),'%'), col=c('red','blue'), init.angle=90, clockwise=T,
    main='1970년 노래 가사 속 제목')
pie(p[2,], labels=paste0(colnames(p),'\n',round(p[2,]*100),'%'), col=c('red','blue'), init.angle=90, clockwise=T,
    main='1980년 노래 가사 속 제목')
pie(p[3,], labels=paste0(colnames(p),'\n',round(p[3,]*100),'%'), col=c('red','blue'), init.angle=90, clockwise=T,
    main='1990년 노래 가사 속 제목')
pie(p[4,], labels=paste0(colnames(p),'\n',round(p[4,]*100),'%'), col=c('red','blue'), init.angle=90, clockwise=T,
    main='2000년 노래 가사 속 제목')
pie(p[5,], labels=paste0(colnames(p),'\n',round(p[5,]*100),'%'), col=c('red','blue'), init.angle=90, clockwise=T,
    main='2010년 노래 가사 속 제목')
